library(ggplot2)
dogs <- read.csv("../hw6/dogs.csv")
dogs <- na.omit(dogs) #lets clean the data for ggplot
#################################################################
# 1a.
str(dogs)  # Structure of the dataset (including column data types and #row,col)
print(dim(dogs))  # Number of rows and columns
print(names(dogs))  # Column names
#################################################################
# 1b. Scatter plot of height vs weight
print(ggplot(dogs, aes(x = height, y = weight)) +
  geom_point() +
  labs(title = "Relationship between Dog Height and Weight",
       x = "Height (inches)",
       y = "Weight (pounds)"))
# As expected the plot is showing that there is a positive correlation
# between the height of the dogs and the weight of the dogs. We also 
# see that the taller/heavier a dog is, the fewer there are. 
#################################################################
# 1c.
print(ggplot(dogs, aes(x = height, y = weight)) +
  geom_point(color = "#FC5310") +  # Using Aerospace orange from coolors.co
  labs(title = "Relationship between Dog Height and Weight",
       x = "Height (inches)",
       y = "Weight (pounds)"))
#################################################################
# 2a. Bar plot showing number of dogs in each group
print(ggplot(dogs, aes(x = group)) +
  geom_bar() +
  labs(title = "Number of Dogs in Each Group",
       x = "Dog Group",
       y = "Count"))
#################################################################
# 2b. The bar plot shows that theres about 2.5 times less herding
#   dogs than average, and about 2.5 time more sporting dogs than
#   average.
#################################################################
# 2c. Fill bars based on dog size with position adjustment
print(ggplot(dogs, aes(x = group, fill = size)) +
  geom_bar(position = "dodge") +
  labs(title = "Number of Dogs in Each Group by Size",
       x = "Dog Group",
       y = "Count"))
# I chose "dodge" position because it places the bars for different sizes 
# side by side, making it easier to compare the number of dogs of each size 
# within each group. This allows for direct comparison across both groups 
# and sizes simultaneously.
#################################################################
# 3a. The geometry function for histograms is geom_histogram()
#################################################################
# 3b. Histogram of dog longevity
print(ggplot(dogs, aes(x = longevity)) +
  geom_histogram() +
  labs(title = "Distribution of Dog Longevity",
       x = "Longevity (years)",
       y = "Count"))
# The historam is showing that most of the dogs live about 12 or 13 years.
#################################################################
# 3c. Playing with the bins argument
print(ggplot(dogs, aes(x = longevity)) +
  geom_histogram(bins = 50) +
  labs(title = "Distribution of Dog Longevity (50 bins)",
       x = "Longevity (years)",
       y = "Count"))
# The bins argument controls how many bars (bins) are used to divide the range 
# of the data. More bins provide more detail but can make patterns harder 
# to see; fewer bins simplify the visualization but might hide important details
#################################################################
# 4a. Scatter plot with different shapes for different groups
print(ggplot(dogs, aes(x = height, y = weight, shape = group, color = group)) +
  geom_point() +
  scale_shape_manual(values = c(0, 1, 2, 3, 4, 5, 6, 7)) +#fixing default 6 limit
  labs(title = "Relationship between Dog Height and Weight by Group",
       x = "Height (inches)",
       y = "Weight (pounds)"))
#################################################################
# 4b. The working on average seem to be the largest and heaviest. There are not
#   really any clear boundaries between the groups, as they seem pretty evenly
#   spread out along the distribution. The only groups that seems to be mostly
#   grouped together is the hounds and the working dogs.
#################################################################
# 4c. For starters, colors rather than shapes to differentiate the groups.
#   There also are only 6 default shapes so working dogs just don't show up.
#   we can fix this issue but it might be easier to just use colors, or both.
#################################################################
# 5a. The intended audience for this visualization appears to be potential dog
# owners and enthusiasts. This audience focus likely influenced:
# -Data collection that emphasizes metrics appealing to pet owners 
#   (intelligence, grooming needs, costs, longevity)
# -The calculation of an overall "data score" that weights these attributes 
#   based on what typical pet owners might value
# -Visual design choices like silhouettes instead of photos, 
#   which makes the breeds easy to compare at a glance
# -The categorization of dogs into groups like "Hot Dogs!" 
#   "Inexplicably Overrated" and "Overlooked Treasures" 
#   which uses playful language to engage casual viewers rather than 
#   professional breeders or veterinarians
#################################################################
# 5b. This visualization includes:
# -Primarily purebred dogs recognized by kennel clubs
# -Metrics that focus on pet ownership qualities
# -Dogs categorized by popularity and data score  
# It excludes:
# -Mixed-breed dogs, which make up a large percentage of actual pet dogs
# -Regional or rare breeds that might not be globally recognized
# -Working dogs valued for specific skills rather than general pet attributes
# -Metrics related to specific uses (like herding, guarding, 
#   or service capabilities)
# The impact of these exclusions is that viewers might develop a 
# skewed understanding of which dogs make "good pets" based on limited criteria.
# People may overlook mixed-breed dogs or dogs whose strengths aren't captured 
# in the selected metrics.
#################################################################
# 5c. Impact on Those Left Out
# -Continued stigma against mixed-breed dogs in favor of "designer" purebreds
# -Lower adoption rates for dogs not featured or categorized as "overlooked"
# -Perpetuation of breed stereotypes that may not be scientifically valid
# -Economic impacts on breeders and rescues focusing on excluded breeds
# -Health consequences for dogs bred for appearance rather than health factors
# This visualization, while informative and visually appealing, 
# reinforces a particular view of dog ownership that may not align with 
# animal welfare best practices or reflect the diverse roles dogs 
# play in human society.
#################################################################
# 6a. https://viz.wtf/image/646651837987061760
#################################################################
# 6b. The. "data story" the visualization is trying to tell is that 44% of
#   people polled believe that Nebraska should legalize marijuana.  It is not
#   clear if the people polled live in Nebraska or not. The graphic is trying 
#   to indicate that there are more people in approval than there actually are.
#################################################################
# 6c. 
# -3D Distortion: The 3D effect creates a visual distortion that makes the 
#   "NO" slice appear smaller than it actually is relative to the percentages 
#   shown. This violates the principle that area should be proportional 
#   to the data values.
# -Perspective Skew: The angle of the 3D perspective further exaggerates 
#   the size difference between the slices, creating an illusion that 
#   the difference is more dramatic than 56% vs 44%.
# -Poor Color Choice: The colors lack sufficient contrast for accessibility, 
#   and there's no logical reason for the color assignment 
#   (blue for yes, orange for no).
# -Missing Context: The visualization provides no information about 
#   sample size, methodology, or margin of error, making it impossible to 
#   evaluate the reliability of the results.
# -Unnecessary Complexity: A simple 2D pie chart or horizontal bar chart 
#   would have communicated this information more clearly and accurately.
# Improvements would include:
#   -Remove the 3D effect entirely
#   -Use a horizontal bar chart instead of a pie chart 
#   -Add sample size and methodology information
#   -Use colors with better contrast and consistent meaning
#   -Include margin of error
#################################################################
# 6d. Despite its flaws, the visualization does clearly label both the 
#   percentage values and the categories (YES/NO) directly on the chart itself, 
#   eliminating the need for a separate legend and making the basic results 
#   immediately readable.
#################################################################
# 7a. 
# Marks:
#   Points (different shapes representing different dog groups)
# Channels:
#   -Position (x-axis for longevity in years, y-axis for lifetime cost)
#   -Shape (different symbols for different dog groups)
#   -Color (different colored symbols for different dog groups)
#   -Size (all points are the same size)
#################################################################
# 7b. 
print(ggplot(dogs, aes(x = longevity, y = lifetime_cost, shape = group, color = group)) +
  geom_point() +
  scale_shape_manual(values = c(0, 1, 2, 3, 4, 5, 6, 7)) +
  labs(title = "Dogs",
       x = "Longevity (years)",
       y = "lifetime_cost") +
  theme_minimal() +
  theme(panel.grid = element_line(color = "lightgray"),
        panel.background = element_rect(fill = "white")))
#################################################################
# 7c.
# -Add a more descriptive title and axis titles: The current title 
#   "Dogs" is too vague, and the y-axis label isn't properly formatted.
# -Consider using fewer visual variables: Using both shape and color to 
#   represent the same variable (group) is redundant and can make the plot 
#   busier than necessary.
# -Add a trend line or smoothed line: 
#   This would help visualize the overall relationship between 
#   longevity and cost.
# -Improve the legend placement and clarity: 
#   The legend could be positioned better to not take up so much space on 
#   the right side of the plot.
#################################################################
# 7d.
print(ggplot(dogs, aes(x = longevity, y = lifetime_cost, color = group)) +
  geom_point(alpha = 0.8) +  # Using just color (not shape), added transparency 
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +  # Added trend line
  labs(title = "Relationship Between Dog Longevity and Lifetime Cost",  # Better title
       subtitle = "By dog group classification",
       x = "Longevity (years)",
       y = "Lifetime Cost ($)") +  # Better y-axis label
  theme_minimal() +
  theme(panel.grid = element_line(color = "lightgray"),
        panel.background = element_rect(fill = "white"),
        legend.position = "bottom"))  # Moved legend to bottom