install.packages("rvest")
library(rvest)

# retrieve the html page
# read_html () function retrives the HTML downloaded using the UrL passed as parameter
document <- read_html("https://scrapeme.live/shop")

# identify and select the most important HTML elements
# selecting the list of product HTML elements
# %>% is a pipe operator, html_elements() returns the list of HTML elements found applying a CSS selector or XPath expression
html_products <- document %>% html_elements("li.product")

#

# extracting data from the list of products and storing the scraped data into 4 lists 
product_urls <- html_products %>% 
  html_element("a") %>% 
  html_attr("href") 
product_images <- html_products %>% 
  html_element("img") %>% 
  html_attr("src") 
product_names <- html_products %>% 
  html_element("h2") %>% 
  html_text2() 
product_prices <- html_products %>% 
  html_element("span") %>% 
  html_text2()

# converting the lists containg the scraped data into a dataframe 
products <- data.frame( 
  product_urls, 
  product_images, 
  product_names, 
  product_prices 
)

# export the scrape data to csv
# changing the column names of the data frame before exporting it into csv
names(products) <- c("url", "image", "name", "price")

# export the data frame containing the scraped data to a csv file
write.csv(products, file = "./products.csv", fileEncoding = "UTF-8")
html_products
