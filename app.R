source("chapters_source.R")
library(shinydashboard)
library(shiny)
library(leaflet)

## ui.R ##

## UI CONFIG

## Header
header <- dashboardHeader(title = "R-Ladies")

# Sidebar content
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "R-Ladies", tabName = "R-Ladies", icon = icon("dashboard")),
    menuItem(text = "By Region", tabName = "country", icon = icon("dashboard"))
  )
)

## Body content
body <-   
  dashboardBody(
    tabItems(
      
      # Front Page
      tabItem(
        # h2(HTML("R-Ladies!"),
        #       style = "color: purple;"),
        selected = TRUE, 
        tabName = "R-Ladies",

            fluidRow(
              # A static valueBox
              valueBox(dim(rladies_groups)[1], "R-Ladies groups on meetup.com", 
                       icon = icon("glyphicon-blackboard"), width = 3),
              valueBox(length(unique(rladies_groups$country)), "R-Ladies Countries", 
                       icon = icon("map-o"), width = 3),
              valueBox(length(rladies_groups$city), "R-Ladies Cities", 
                       icon = icon("map-marker"), color = "purple", width = 3),
              valueBox(sum(rladies_groups$members), "R-Ladies members on meetup.com", 
                       icon = icon("users"), width = 3)
            ),
            leafletOutput('map')
          ),
      
      # Second TAB
      tabItem(
        tabName = "country",
        navbarPage(
          title = 'R-Ladies',
          
          tabPanel(
            title = 'USA',
            fluidRow(
              column(
                width = 4,
              # A static valueBox
              valueBox(nrow(groups_usa), "R-Ladies groups in the US", 
                       icon = icon("glyphicon-blackboard"), width = 18
                       ),
              box("Created at", width = 18, tableOutput("created_usa")
                )
              ),
              column(
                width = 8,
              leafletOutput('map_usa',width = 600)
              )
            )
            ),
          tabPanel(
            title = 'Canada',
            fluidRow(
              column(
                width = 4,
                # A static valueBox
                valueBox(nrow(groups_canada), "R-Ladies groups in Canada", 
                         icon = icon("glyphicon-blackboard"), width = 18
                ),
                box("Created at", width = 18, tableOutput("created_canada")
                )
              ),
              column(
                width = 8,
                leafletOutput('map_canada',width = 600)
              )
            )
          ),
          tabPanel(
            title = 'Latin America',
            fluidRow(
              column(
                width = 4,
                # A static valueBox
                valueBox(nrow(groups_latam), "R-Ladies groups in Latin America", 
                         icon = icon("glyphicon-blackboard"), width = 18
                ),
                box("Created at", width = 18, tableOutput("created_latam")
                )
              ),
              column(
                width = 8,
                leafletOutput('map_latam',width = 600))
            )
          ),
          tabPanel(
            title = 'Europe',
            fluidRow(
              column(
                width = 4,
                # A static valueBox
                valueBox(nrow(groups_europe), "R-Ladies groups in Europe",
                         icon = icon("glyphicon-blackboard"), width = 18
                ),
                box("Created at", width = 18, tableOutput("created_europe")
                )
              ),
              column(
                width = 8,
                leafletOutput('map_europe',width = 600))
            )
          ),
          tabPanel(
            title = 'Africa',
            fluidRow(
              column(
                width = 4,
                # A static valueBox
                valueBox(nrow(groups_africa), "R-Ladies groups in Africa", 
                         icon = icon("glyphicon-blackboard"), width = 18
                ),
                box("Created at", width = 18, tableOutput("created_africa")
                )
              ),
              column(
                width = 8,
                leafletOutput('map_africa',width = 600))
            )
          ),
          tabPanel(
            title = 'Asia',
            fluidRow(
              column(
                width = 4,
                # A static valueBox
                valueBox(nrow(groups_asia), "R-Ladies groups in Asia",
                         icon = icon("glyphicon-blackboard"), width = 18
                ),
                box("Created at", width = 18, tableOutput("created_asia")
                )
              ),
              column(
                width = 8,
                leafletOutput('map_asia',width = 600))
            )
          ),
          tabPanel(
            title = 'Australia',
            fluidRow(
              column(
                width = 4,
                # A static valueBox
                valueBox(nrow(groups_australia), "R-Ladies groups in Australia",
                         icon = icon("glyphicon-blackboard"), width = 18
                ),
                box("Created at", width = 18, tableOutput("created_australia")
                )
              ),
              column(
                width = 8,
                leafletOutput('map_australia',width = 600))
            )
          )
        )
      )))




ui <- dashboardPage(header, sidebar, body)


server <- function(input, output) { 
  
  output$map <- renderLeaflet({
    leaflet(data = rladies_groups) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
    # makeAwesomeIcon(markerColor = "purple")
  })
  output$created_usa <- renderTable(created_usa, rownames = FALSE)
  output$map_usa <- renderLeaflet({
    leaflet(groups_usa) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
  })
  output$created_canada <- renderTable(created_canada, rownames = FALSE)
  output$map_canada <- renderLeaflet({
    leaflet(groups_canada) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
  })
  output$created_latam <- renderTable(created_latam, rownames = FALSE)
  output$map_latam <- renderLeaflet({
    leaflet(groups_latam) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
  })
  output$created_europe <- renderTable(created_europe, rownames = FALSE)
  output$map_europe <- renderLeaflet({
    leaflet(groups_europe) %>%
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name))
  })
  output$created_africa <- renderTable(created_africa, rownames = FALSE)
  output$map_africa <- renderLeaflet({
    leaflet(groups_africa) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
  })
  output$created_asia <- renderTable(created_asia, rownames = FALSE)
  output$map_asia <- renderLeaflet({
    leaflet(groups_asia) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
  })
  output$created_australia <- renderTable(created_australia, rownames = FALSE)
  output$map_australia <- renderLeaflet({
    leaflet(groups_australia) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
  })
}


shinyApp(ui, server)








