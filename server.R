#setwd("/Users/Victor/Documents/open-welfare2/")
library(shiny)
library(rgdal)
library(geojsonio)
library(leaflet)
library(dplyr)
shinyServer(function(input,output){
  tw = readOGR("twCounty2010_v4.geo.json", "OGRGeoJSON")
  welfare = read.csv("welfare_data.csv", header=TRUE)
  welfare$SERIAL <- as.factor(welfare$SERIAL)
  welfare$value <- as.numeric(welfare$value)

  #May not be necessary
  output$category <- renderUI({
    radioButtons("category", "Select child number:",
                 choices = levels(welfare$category),
                 selected = "First")
  })  
  
#   output$myList <- renderUI({
#     selectInput("compName", "Company Name:", LETTERS[1:4])
#   })
#   
#   output$myNumbers <- renderUI({
#     selectInput("compNo", "Product Line:", myDF[, input$compName])
#   })
  
  #Maybe add in second curly bracket for dynamic change of area
  selected <- reactive({
    subset(welfare,
           category==input$category)
  })

    
  output$map <- renderLeaflet({
    leaflet() %>% 
    addTiles() %>% 
    addPolygons(data=tw,weight=2) %>%
    setView(lng = 120.9605, lat = 22.6978,  zoom = 7)
    
  })
  
  observe({
    
    tw@data <- left_join(tw@data, selected())
    qpal <- colorNumeric(
      palette = "YlGn",
      domain = tw$value
    )
      #For % range:
      #colorQuantile("YlGn", tw$money, n = 3, na.color = "#bdbdbd") 
            
    popup <- paste0("<strong>County: </strong>",
                    tw$area," (",tw$COUNTYNAME,")",
                    "<br><strong>Population (2015): </strong>",
                    tw$POPULATION,
                    "<br><strong>Category: </strong>",
                    tw$category,
                    "<br><strong>Value: </strong>",
                    tw$value,
                    "<br>",tw$description)

    
    leafletProxy("map", data = tw) %>%
      addProviderTiles("CartoDB.Positron") %>% 
      clearShapes() %>% 
      clearControls() %>% 
      addPolygons(data=tw,fillColor = ~qpal(value), fillOpacity = 0.7, 
                  color = "white", weight=2,popup=popup)  %>%
      addLegend(pal = qpal, values = ~value, opacity = 0.7,
                position = 'bottomright', 
#                labFormat = labelFormat(prefix = "$"),
                title = paste0(input$category)) #%>%
#      setView(lng = lng, lat = lat, zoom = zoom)
  })
  
  observe({
    leafletProxy("map")
  })
  
}) 


# Working Map
# library(rgdal)
# "GeoJSON" %in% ogrDrivers()$name
# 
# tw = readOGR("/Users/Victor/Documents/open-welfare/twCounty2010.geo.json", "OGRGeoJSON")
# plot(tw)
# 
# tw <- as.data.frame(tw)
#   leaflet() %>% 
#     addTiles() %>% 
#     addPolygons(data=tw,weight=2)





## Working Shiny Leaflet Map:
#setwd("/Users/Victor/Documents/open-welfare/")
# library(shiny)
# library(rgdal)
# library(geojsonio)
# library(leaflet)
# shinyServer(function(input,output){
#   tw = readOGR("/Users/Victor/Documents/open-welfare2/twCounty2010.geo.json", "OGRGeoJSON")
#   
#   output$map <- renderLeaflet({
#     leaflet() %>% 
#       addTiles() %>% 
#       addPolygons(data=tw,weight=2)
#     
#   })
#   
# })  

