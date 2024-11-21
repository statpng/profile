#MathOutput {
    margin-top: 5px !important;
    font-size: 20px !important;
    width: 878px !important;
    height: 1000px !important;
    border: 0px solid #999999;
    text-align: left;
}
#ForLatext {
    margin-top: 30px;
    width: 1578px !important;
    height: 1800px !important;
    overflow: auto;
}


body {
    margin: 0px;
    padding: 0px;
    color: white !important;
    background: #FFFFFF url(Image/Body.jpg) repeat-x left top;
    font-family: verdana, arial, helvetica, sans-serif;
}


#copyright {
    clear: both;
    text-align: center;
    font-size: 10px;
    padding: 11px;
    background: #CACACA url(Image/barCopyRight.gif) repeat-x left top;
    border-top-style: solid;
    border-top-color: #cccccc;
    border-top-width: 1px;
    display: none !important;
}

#container {
    border: 1px solid #999999;
    padding: 0px;
    margin: 0px auto;
    width: 1000px !important;
    height: 2000px !important;
    min-height: 100%;
    color: #333333;
    background-color: #FFFFFF;
    border: none !important;
}


.ui-tabs {
    position: relative;
    padding: .0em;
    zoom: 0;
    display: none !important;
}

.SingleButton {
    cursor: pointer;
    display: inline-block;
    text-decoration: underline;
    margin-left: 15px;
    display: none !important;
}

.ui-tabs .ui-tabs-panel {
    display: none !important;
    border-width: 0;
    padding: 5px 5px;
    background: none;
    font-size: -23px;
    min-height: 468px;
}


element.style {
    width: 0% !important;
    display: none !important;
}


#content{
    font-family: verdana, arial, helvetica, sans-serif;
    color: #333333;
    font-style: normal;
    font-weight: normal;
    font-size: 100%;
    font-size-adjust: none;
    text-indent: 0;
    text-align: left;
    text-transform: none;
    letter-spacing: normal;
    word-spacing: normal;
    word-wrap: normal;
    direction: ltr;
    white-space: nowrap!important;
    -webkit-transition: none;
    position: static;
    border: 0;
    padding: 0;
    margin: 0;
    vertical-align: 0;
    line-height: normal;
    text-decoration: none;
    width: 100%;
    display: inline-block;
    min-width: 53.018em;
}
