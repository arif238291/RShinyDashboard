library("DT")
navbarPage(
  "Md Ariful Islam Works on World Bank Data",
  tabPanel(
    "Selected indicator",
    fluidPage(
      fluidRow(
        column(
          selectInput(
            "selected_continent",
            label="Select a Continent",
            choices = NULL
          ), 
          width=3
        ),
        column(
          selectInput(
            "selected_country",
            label="Select a Country",
            choices = NULL
          ), 
          width=4
        ),
        column(
          selectInput("selected_indicator",
                      "Select an indicator",
                      choices = NULL,
                      width = "100%"),
          width = 5
        )
      )
    ),
    actionButton("update_chart", label = "Update chart", width = "100%"),
    plotOutput("wdi_indicator_chart")
  ), collapsible = TRUE
)