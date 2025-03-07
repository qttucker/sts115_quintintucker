
# Load required libraries
library(xml2)
library(rvest)

# Function to parse article links from a page
parse_article_links <- function(page) {
  # Find article containers with more flexible selectors
  # Try multiple potential article container classes
  content_divs <- xml_find_all(page, "//div[contains(@class, 'td_block_inner') or contains(@class, 'tdb-block-inner')]")
  
  # If no specific container found, try more general content containers
  if (length(content_divs) == 0) {
    content_divs <- xml_find_all(page, "//div[contains(@class, 'main-content') or contains(@class, 'content')]")
  }
  
  # If still nothing found, use the whole body as container
  if (length(content_divs) == 0) {
    content_divs <- xml_find_all(page, "//body")
  }
  
  # Look for article headings with links 
  # Most article titles are in h2 or h3 elements with links
  links <- xml_find_all(content_divs, ".//h3/a | .//h2/a")
  
  # Extract the URLs from links
  urls <- xml_attr(links, "href")
  
  # Filter URLs to ensure they're article links
  # Article URLs typically include date patterns
  article_pattern <- "/[0-9]{4}/[0-9]{2}/[0-9]{2}/"
  urls <- urls[grepl(article_pattern, urls)]
  
  # Find pagination elements - try multiple possible containers
  nav_elements <- xml_find_all(page, "//div[contains(@class, 'page-nav')] | //nav[contains(@class, 'pagination')] | //div[contains(@class, 'nav-links')]")
  
  # Find the next page link using multiple possible selectors
  next_url <- NA
  if (length(nav_elements) > 0) {
    next_page <- xml_find_all(nav_elements, ".//a[contains(@aria-label, 'next') or contains(@class, 'next') or text()='Next']")
    if (length(next_page) > 0) {
      next_url <- xml_attr(next_page[1], "href")
    }
  }
  
  # Return both the article URLs and the next page URL
  list(urls = urls, next_url = next_url)
}

# Function to scrape all feature article links
get_all_feature_links <- function() {
  url <- "https://theaggie.org/category/features/"
  article_urls <- list()
  page_num <- 1
  max_pages <- 200  # Safety limit to prevent infinite loops
  
  # Loop until there's no next page or we reach our safety limit
  while (!is.na(url) && page_num <= max_pages) {
    cat("Processing page", page_num, ":", url, "\n")
    
    # Download the page with error handling
    page <- try(read_html(url), silent = TRUE)
    
    if (inherits(page, "try-error")) {
      warning("Error downloading page ", page_num, ": ", url)
      page <- try(read_html(url), silent = TRUE)
      if (inherits(page, "try-error")) {
        warning("Failed after retry, stopping")
        break
      }
    }
    
    # Extract links from the page
    result <- parse_article_links(page)
    
    # Check if we found any links
    if (length(result$urls) == 0) {
      warning("No article links found on page ", page_num, ". Check selectors.")
    } else {
      cat("Found", length(result$urls), "article links on this page\n")
    }
    
    # Save the links for this page
    article_urls[[page_num]] <- result$urls
    
    # Move to the next page
    url <- result$next_url
    page_num <- page_num + 1
    
  }
  
  # Flatten the list of URLs and remove duplicates
  all_urls <- unique(unlist(article_urls))
  
  return(all_urls)
}

# Execute the scraper
cat("Starting web scraping of The California Aggie features...\n")
feature_links <- get_all_feature_links()

# Report results
cat("\nScraping complete!\n")
cat("Found", length(feature_links), "unique feature article links\n")

# Print sample of the results
if (length(feature_links) > 0) {
  cat("\nSample of article links:\n")
  print(head(feature_links))
}