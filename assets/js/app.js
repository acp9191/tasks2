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

  let currently_timing = false;
  let start_date = '';
  let end_date = '';

  function update_blocks(task_id) {
    $.ajax(`${time_block_path}?task_id=${task_id}`, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        // no op
      },
    });
  }

  $('#direct-time-button').click((ev) => {
    currently_timing = !currently_timing;
    if (currently_timing) {
      ev.target.innerText = "Stop Time Block";
      ev.target.classList.remove("btn-success")
      ev.target.classList.add("btn-danger")
      start_date = new Date().toISOString();
    } else {
      ev.target.innerText = "Start Time Block";
      ev.target.classList.remove("btn-danger")
      ev.target.classList.add("btn-success")
      end_date = new Date().toISOString();

      let task_id = $(ev.target).data('task-id');

      let text = JSON.stringify({
        time_block: {
          task_id: task_id,
          is_direct: true,

          start_date: start_date,
          end_date: end_date
        },
      });

      $.ajax(time_block_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
          start_date = '';
          end_date = '';
          update_blocks(task_id);
        },
      });
    }
  });

  $('#time-button').click((ev) => {
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
        is_direct: false,

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
        $('#start-year').val("");
        $('#start-month').val("");
        $('#start-day').val("");
        $('#start-hour').val("");
        $('#start-minute').val("");
        $('#start-second').val("");

        $('#end-year').val("");
        $('#end-month').val("");
        $('#end-day').val("");
        $('#end-hour').val("");
        $('#end-minute').val("");
        $('#end-second').val("");
        update_blocks(task_id);
      },
    });
  });
});