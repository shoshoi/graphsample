# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  dateFormat = 'yy-mm-dd';
  $('.date-picker').datepicker(
    dateFormat: dateFormat
  );
$(document).ready(ready)
$(document).on('turbolinks:load', ready)
window.draw_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    result = []
    for value, index in gon.data
        obj = {
            x: new Date(value.t)
            y: value.y
        }
        result.push obj
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            datasets: [{
                label: 'sample1 (dist: linear)',
                data: result,
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    type: "time",
                    time: {
                        format: "YYYY-MM-DD",
                        unit: "day",
                        displayFormats: {
                            day: 'YYYY-MM-DD'
                        },
                        tooltipFormat: 'YYYY-MM-DD'
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Date'
                    }
                },],
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'points'
                    },
                    ticks: {
                        beginAtZero: true
                    }
                }]
            },
        }
    })
