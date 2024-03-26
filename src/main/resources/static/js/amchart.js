am5.ready(function() {

// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element

var root = am5.Root.new("chartdiv1");

// Set themes
// https://www.amcharts.com/docs/v5/concepts/themes/
root.setThemes([
  am5themes_Animated.new(root)
]);

// Generate and set data
// https://www.amcharts.com/docs/v5/charts/radar-chart/#Setting_data
var cat = -1;
var value = 10;

function generateData() {
  value = Math.round(Math.random() * 10);
  cat++;
  return {
    category: "cat" + cat,
    value: value
  };
}

function generateDatas(count) {
  cat = -1;
  var data = [];
   $.ajax({
    type : "POST",            // HTTP method type(GET, POST) 형식이다.
        url : "/user/aaa.do",      // 컨트롤러에서 대기중인 URL 주소이다.
        data : {
          email : $("#email").val()
        },
        async: false,
        success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            // 응답코드 > 0000
            for(var i = 0; i < res.resultList.length; i++) {
              var data2 = {};
              data2.category = res.resultList[i]['subjectCode'];
              switch (data2.category) {
                case '10':
                  data2.category = 'JAVA';
                  break;
                case '20':
                  data2.category = 'Spring';
                  break;
                case '21':
                  data2.category = 'Flask';
                  break;
                case '30':
                  data2.category = 'SQL';
                case '31':
                  data2.category = 'Django';
                  break;
                case '40':
                  data2.category = 'Python';
                  break;
                case '50':
                  data2.category = 'C++';
                  break;
                case '60':
                  data2.category = 'SpringBoot';
                  break;
                case '61':
                  data2.category = '유투브검색기사';
                  break;                                    
              }
              data2.value = res.resultList[i]['score'];
              data.push(data2);
            }
           
            
            
        },
        error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
        }
  })
  return data;
}

// Create chart
// https://www.amcharts.com/docs/v5/charts/radar-chart/
var chart = root.container.children.push(
  am5radar.RadarChart.new(root, {
    panX: false,
    panY: false,
    wheelX: "panX",
    wheelY: "zoomX",
    innerRadius: am5.p50,
    layout: root.verticalLayout
  })
);

// Create axes and their renderers
// https://www.amcharts.com/docs/v5/charts/radar-chart/#Adding_axes
var xRenderer = am5radar.AxisRendererCircular.new(root, {});
xRenderer.labels.template.setAll({
  textType:"adjusted"
});

var xAxis = chart.xAxes.push(
  am5xy.CategoryAxis.new(root, {
    maxDeviation: 0,
    categoryField: "category",
    renderer: xRenderer,
    tooltip: am5.Tooltip.new(root, {})
  })
);

var yAxis = chart.yAxes.push(
  am5xy.ValueAxis.new(root, {
    min: 0,
    max: 100,
    renderer: am5radar.AxisRendererRadial.new(root, {})
  })
);



// Create series
// https://www.amcharts.com/docs/v5/charts/radar-chart/#Adding_series
for (var i = 0; i < 1; i++) {  
  var series = chart.series.push(
    am5radar.RadarColumnSeries.new(root, {
      stacked: true,
      name: "성적 ",
      xAxis: xAxis,
      yAxis: yAxis,
      valueYField: "value",
      categoryXField: "category"
    })
  );

  series.columns.template.setAll({
    tooltipText: "{name}: {valueY}"
  });

  series.data.setAll(generateDatas(6));
  series.set("fill", am5.color(0xfea443)); // set Series color to red
  series.appear(1000);
}

// slider
var slider = chart.children.push(
  am5.Slider.new(root, {
    orientation: "horizontal",
    start: 0.5,
    width: am5.percent(60),
    centerY: am5.p50,
    centerX: am5.p50,
    x: am5.p50
  })
);
slider.events.on("rangechanged", function () {
  var start = slider.get("start");
  var startAngle = 270 - start * 179 - 1;
  var endAngle = 270 + start * 179 + 1;

  chart.setAll({ startAngle: startAngle, endAngle: endAngle });
  yAxis.get("renderer").set("axisAngle", startAngle);
});

var data = generateDatas(6);
xAxis.data.setAll(data);

// Animate chart
// https://www.amcharts.com/docs/v5/concepts/animations/#Initial_animation
chart.appear(1000, 100);

}); // end am5.ready()
