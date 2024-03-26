am5.ready(function() {


// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element
var root = am5.Root.new("stepcountchartdiv");

// Set themes
// https://www.amcharts.com/docs/v5/concepts/themes/
root.setThemes([
  am5themes_Animated.new(root)
]);

root.dateFormatter.setAll({
  dateFormat: "yyyy-MM-dd",
  dateFields: ["valueX"]
});

function generateDatas(count) {
    var data = [];
    $.ajax({
        type: "POST", // HTTP method type(GET, POST) 형식이다.
        url: "/main/GetCountData.do", // 컨트롤러에서 대기중인 URL 주소이다.
        async: false,
        data: {
            email: $("#emailval").val()
        }, // 데이터 전송
        success: function (res) { // 비동기통신의 성공일 경우 success 콜백으로 들어옵니다. 'res'는 응답받은 데이터입니다.
            // 응답코드 > 0000
            for (var i = 0; i < res.resultList.length; i++) {
                var data2 = {};
                data2.date = res.resultList[i]["dateCalId"];
                data2.steps = res.resultList[i]['cntTrainee'];
                data.push(data2);
            }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할 경우 error 콜백으로 들어옵니다.
            alert("통신 실패.");
        }
    });
    return data;
}

// Create chart
// https://www.amcharts.com/docs/v5/charts/xy-chart/
var chart = root.container.children.push(
  am5xy.XYChart.new(root, {
    focusable: true,
    panX: true,
    panY: false,
    wheelX: "panX",
    wheelY: "none",
    paddingLeft: 0,
    paddingRight: 0
  })
);

var easing = am5.ease.linear;

// hide zoomout button
chart.zoomOutButton.set("forceHidden", true);

// add label
chart.plotContainer.children.push(
  am5.Label.new(root, { text: "출석수의 최대 값은 반 학생 수", x: 100, y: 50 })
);

// Create axes
// https://www.amcharts.com/docs/v5/charts/xy-chart/axes/
var xRenderer = am5xy.AxisRendererX.new(root, {
  minGridDistance: 50,
  strokeOpacity: 0.2,
  minorGridEnabled: true
});
xRenderer.grid.template.set("forceHidden", true);

var xAxis = chart.xAxes.push(
  am5xy.DateAxis.new(root, {
    maxDeviation: 0.49,
    snapTooltip: false,
    baseInterval: {
      timeUnit: "day",
      count: 1
    },
    renderer: xRenderer,
    tooltip: am5.Tooltip.new(root, {})
  })
);

var yRenderer = am5xy.AxisRendererY.new(root, { inside: true });
yRenderer.grid.template.set("forceHidden", true);

var yAxis = chart.yAxes.push(
  am5xy.ValueAxis.new(root, {
    renderer: yRenderer,
    min : 0,
    max : 20
  })
);

// Add series
// https://www.amcharts.com/docs/v5/charts/xy-chart/series/
var series = chart.series.push(
  am5xy.ColumnSeries.new(root, {
    xAxis: xAxis,
    yAxis: yAxis,
    valueYField: "steps",
    valueXField: "date",
    tooltip: am5.Tooltip.new(root, {
      pointerOrientation: "vertical",
      labelText: "{valueY}"
    })
  })
);



series.columns.template.setAll({
  cornerRadiusTL: 15,
  cornerRadiusTR: 15,
  maxWidth: 30,
  strokeOpacity: 0
});

series.columns.template.adapters.add("fill", function (fill, target) {
  if (target.dataItem.get("valueY") < 11) {
    return am5.color(0xdadada);
  }
  return fill;
});

series.set("fill", am5.color(0xfea443)); // set Series color to red


// Set up data processor to parse string dates
// https://www.amcharts.com/docs/v5/concepts/data/#Pre_processing_data
series.data.processor = am5.DataProcessor.new(root, {
  dateFormat: "yyyy-MM-dd",
  dateFields: ["date"]
});

series.data.setAll(generateDatas(30));

// do not allow tooltip  to move horizontally
series.get("tooltip").adapters.add("x", function (x) {
  return chart.plotContainer.toGlobal({
    x: chart.plotContainer.width() / 2,
    y: 0
  }).x;
});




// Add cursor
// https://www.amcharts.com/docs/v5/charts/xy-chart/cursor/
var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {
  alwaysShow: true,
  behavior: "none",
  positionX: 0.5 // make it always be at the center
}));
cursor.lineY.set("visible", false);

// zoom to last 11 days
series.events.on("datavalidated", function () {
  var toTime =
    series.dataItems[series.dataItems.length - 1].get("valueX") +
    am5.time.getDuration("day", 1);
  var fromTime = series.dataItems[series.dataItems.length - 11].get("valueX");

  xAxis.zoomToValues(fromTime, toTime);
});

// when plot are is released, round zoom to nearest days
chart.plotContainer.events.on("globalpointerup", function () {
  var dayDuration = am5.time.getDuration("day", 1);

  var firstTime = am5.time
    .round(new Date(series.dataItems[0].get("valueX")), "day", 1)
    .getTime();
  var lastTime =
    series.dataItems[series.dataItems.length - 1].get("valueX") + dayDuration;
  var totalTime = lastTime - firstTime;
  var days = totalTime / dayDuration;

  var roundedStart =
    firstTime + Math.round(days * xAxis.get("start")) * dayDuration;
  var roundedEnd =
    firstTime + Math.round(days * xAxis.get("end")) * dayDuration;

  xAxis.zoomToValues(roundedStart, roundedEnd);
});


// Make stuff animate on load
// https://www.amcharts.com/docs/v5/concepts/animations/
chart.appear(1000, 50);

}); // end am5.ready()