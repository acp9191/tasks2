// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";
import _ from "lodash";

$(function () {

  function update_blocks(task_id) {
    $.ajax(`${time_block_path}?task_id=${task_id}`, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        console.log(resp)
        // let count = resp.data.length;
        // let sum = _.sum(_.map(resp.data, (rat) => rat.stars));
        // $('#rating-avg').text(`${sum/count} / 5 (${count} ratings)`);
      },
    });
  }

  $('#time-button').click((ev) => {
    console.log("foo")
    let start_year = parseInt($('#start-year').val());
    let start_month = parseInt($('#start-month').val());
    let start_day = parseInt($('#start-day').val());
    let start_hour = parseInt($('#start-hour').val());
    let start_minute = parseInt($('#start-minute').val());
    let start_second = parseInt($('#start-second').val());

    let end_year = parseInt($('#end-year').val());
    let end_month = parseInt($('#end-month').val());
    let end_day = parseInt($('#end-day').val());
    let end_hour = parseInt($('#end-hour').val());
    let end_minute = parseInt($('#end-minute').val());
    let end_second = parseInt($('#end-second').val());

    let task_id = $(ev.target).data('task-id');

    let text = JSON.stringify({
      time_block: {
        task_id: task_id,

        start_year: start_year,
        start_month: start_month,
        start_day: start_day,
        start_hour: start_hour,
        start_minute: start_minute,
        start_second: start_second,

        end_year: end_year,
        end_month: end_month,
        end_day: end_day,
        end_hour: end_hour,
        end_minute: end_minute,
        end_second: end_second
      },
    });

    $.ajax(time_block_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        update_blocks(task_id);
        console.log(resp);
        // $('#rating-form').text(`(your rating: ${resp.data.stars})`);
      },
    });
  });
});