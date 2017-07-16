#' Event Listeners for d3vennR.
#'
#' @param venn A \code{d3vennR} object.
#' @param input_id The input id, which should be changed by this listener
#' @param eventType The javascript event type (e.g. "click")
#' @export
venn_listener <- function(venn, input_id, eventType = "click"){
    venn$x$tasks[length(venn$x$tasks) + 1] <- list(
        htmlwidgets::JS(paste0('
                        function() {
                            var div = d3.select(this);
                            
                            div.selectAll("g")
                                .on("', eventType, '", function(d, i) {
                                    // sort all the areas relative to the current item
                                    venn.sortAreas(div, d);
                                    
                                    s = d;
                                    s["event_serial"] = Math.random();
                                    Shiny.onInputChange("', input_id, '", s);
                                })
                        }')
        )
    )
    venn
}
