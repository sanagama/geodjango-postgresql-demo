// user gauge settings
var userGaugeMax = 15000, 
    userGaugeShowMax = 6500, 
    userConnectionWindow = 250;

// compute gauge settings
var computeGaugeMax = 50;

$(function () {
    // consts
    var userComputeGauteRelation = 0.0073;

    // USERS
    var userCount = 10;
    var userUpdate = createGraph("#0078d7", "Users", 0);
    userUpdate(userCount, userGaugeMax);
    setInterval(function () {
        var currentVal = userCount; // GET
        var maxVal = userGaugeShowMax;
        var newVal = currentVal + Math.round(userConnectionWindow * Math.random());
        newVal = Math.min(newVal, maxVal);
        if (newVal >= userGaugeShowMax) {
            newVal = newVal - Math.round(15 * Math.random());
        }

        userCount = newVal;         // SET
        userUpdate(newVal, userGaugeMax);
    }, 1000);

    // COMPUTE
    if (document.drawCompute) {
        var computeCount = 1;
        var computeUpdate = createGraph("#a2e016", "Compute\nUnits", 155);
        computeUpdate(computeCount, computeGaugeMax);
        setInterval(function () {
            var newVal = Math.round(userCount * userComputeGauteRelation);

            computeCount = newVal;              // SET
            computeUpdate(newVal, computeGaugeMax);
        }, 1000);
    }
});

var width = 70;
var height = 70;
var range = (2 * Math.PI) / (3 / 2);
var arc = d3.arc()
    .innerRadius(height - 25)
    .outerRadius(height)
    .startAngle(0);

function createGraph(bgColor, label, x) {

    // Get the SVG container, and apply a transform such that the origin is the
    // center of the canvas. This way, we don’t need to position arcs individually.
    var svg = d3.select("svg"),
        g = svg.append("g").attr("transform", "translate(" + (width + x) + "," + height + ") rotate(240)"),
        textContainer = svg.append('g').attr("transform", "translate(" + (width + x) + "," + height + ")");

    // Add the background arc, from 0 to 100% (tau).
    var background = g.append("path")
        .datum({ endAngle: range })
        .style("fill", "rgba(0,0,0,.3)")
        .attr("d", arc);

    // Add the foreground arc in orange, currently showing 12.7%.
    var foreground = g.append("path")
        .datum({ endAngle: 0 })
        .style("fill", bgColor)
        .attr("d", arc);

    var labelContainer = textContainer.append('text')
        .style("text-anchor", "middle")
        .attr("class", "gauge_label");

    var tokens = label.split('\n');
    for (var i = 0; i < tokens.length; i++) {
        labelContainer.append('tspan')
            .attr('x', '0')
            .attr('dy', (1 * i) + 'em')
            .text(tokens[i]);
    }

    var yOffset = -10 * (tokens.length - 1);
    labelContainer.attr('transform', 'translate(0, ' + yOffset + ')');

    var valueLabel = textContainer.append('text')
        .attr('transform', 'translate(0, 40)')
        .style("text-anchor", "middle");

    // Every so often, start a transition to a new random angle. The attrTween
    // definition is encapsulated in a separate function (a closure) below.
    // d3.interval(function () {
    //     foreground.transition()
    //         .duration(750)
    //         .attrTween("d", arcTween(Math.random() * tau));
    // }, 1500);

    return function update(newVal, maxVal) {
        var tweenAngle = (range / maxVal) * newVal;
        foreground.transition()
            .duration(1000)
            .attrTween("d", arcTween(tweenAngle));

        valueLabel.text(newVal.toLocaleString());
    }
}

$(document).keydown(function(e) {
    if (event.which == 114) { //F3
        userGaugeShowMax = 13000;
        computeGaugeMax = 100;
        userConnectionWindow += 101;
    }
});

function arcTween(newAngle) {
    return function (d) {
        var interpolate = d3.interpolate(d.endAngle, newAngle);
        return function (t) {
            d.endAngle = interpolate(t);
            return arc(d);
        };
    };
}