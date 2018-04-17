<!-- <#include "../../snippets/license.ftl"> -->

<#import "../../macros/navigation.ftl" as navigation>

<!DOCTYPE html>
<html lang="en">
<head>
    <base href="../..">
    <#include "../../snippets/common_headers.ftl">
    <#include "../../snippets/css.ftl">
</head>
<body>

<@navigation.build links=["tag_summary", "suite_overview"] />

<main role="main" class="container">
    <div class="cluecumber-template">
        <div class="row">
            <div class="col-sm-6">
                <div class="card h-100">
                    <div class="card-header">Scenario Result Chart</div>
                    <div class="card-body">
                        <div id="canvas-holder" class="w-100 text-center">
                            <canvas id="chart-area" class="w50"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="card h-100">
                    <div class="card-header">Scenario Information</div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>${element.totalNumberOfSteps}</strong> Steps:
                                <strong>${element.totalNumberOfPassedSteps}</strong> passed /
                                <strong>${element.totalNumberOfFailedSteps}</strong> failed /
                                <strong>${element.totalNumberOfSkippedSteps}</strong> skipped
                            </li>
                            <li class="list-group-item"><strong>Total Time:</strong>
                            ${element.returnTotalDurationString()}</li>
                             <#list element.tags as tag>
                                <li class="list-group-item">${tag.name}</li>
                             </#list>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-header text-capitalize">${element.name?html}</div>
                    <#if element.description != "">
                        <div class="card-header text-capitalize text-secondary">${element.description?html}</div>
                    </#if>

                    <div class="card-body">
                        <div class="container" style="border-bottom: black 2px dotted; opacity: 0.5;">
                            <#list element.before as before>
                                <div class="row border border-top-0 border-left-0 border-right-0">
                                    <div class="col-1 text-left">
                                        <span class="text-secondary"><nobr>Before</nobr></span>
                                    </div>
                                    <div class="col-7 text-left">
                                        <i>${before.glueMethodName}</i>
                                    </div>
                                    <div class="col-2 text-left">
                                        <nobr>${before.result.returnDurationString()}</nobr>
                                    </div>
                                    <div class="col-2 text-left">
                                        <#if before.failed>
                                            <#assign class = "text-danger" />
                                        <#elseif before.skipped/>
                                            <#assign class = "text-warning" />
                                        <#else/>
                                            <#assign class = "text-success" />
                                        </#if>
                                        <span class="${class}">${before.status.statusString}</span>
                                    </div>
                                </div>
                                <#if before.failed>
                                    <div class="row border border-top-0 border-left-0 border-right-0">
                                        <div class="col-12 text-left">
                                            <code>${before.result.errorMessage?html}</code>
                                        </div>
                                    </div>
                                </#if>
                            </#list>
                        </div>

                        <div class="container" style="border-bottom: black 2px dotted">
                            <#list element.steps as step>
                                <div class="row border border-top-0 border-left-0 border-right-0">
                                    <div class="col-1 text-left">
                                        <nobr>Step ${step?counter}</nobr>
                                    </div>
                                    <div class="col-7 text-left">
                                        <span data-toggle="tooltip"
                                              title="${step.glueMethodName}">${step.keyword} ${step.name}</span>
                                        <#if (step.rows?size > 0) >
                                            <table class="table table-hover table-sm compact">
                                                <#list step.rows as row>
                                                    <tr>
                                                        <#list row.cells as cell>
                                                            <td>${cell}</td>
                                                        </#list>
                                                    </tr>
                                                </#list>
                                            </table>
                                        </#if>
                                    </div>
                                    <div class="col-2 text-left">
                                        <nobr>${step.result.returnDurationString()}</nobr>
                                    </div>
                                    <div class="col-2 text-left">
                                        <#if step.failed>
                                            <#assign class = "text-danger" />
                                        <#elseif step.skipped/>
                                            <#assign class = "text-warning" />
                                        <#else/>
                                            <#assign class = "text-success" />
                                        </#if>
                                        <span class="${class}">${step.status.statusString}</span>
                                    </div>
                                </div>
                                <#if step.result.hasErrorMessage()>
                                    <div class="row border border-top-0 border-left-0 border-right-0">
                                        <div class="col-12 text-left">
                                            <code>${step.result.errorMessage?html}</code>
                                        </div>
                                    </div>
                                </#if>
                                <#list step.output as output>
                                    <div class="col-12">
                                        <iframe srcdoc="${output?html}" width="100%" height="0" frameborder="0"
                                                scrolling="no" onload="resizeIframe(this);"></iframe>
                                    </div>
                                </#list>
                                <#list step.embeddings as embedding>
                                    <div class="row border border-top-0 border-left-0 border-right-0">
                                        <div class="col-12 text-left">
                                            <#if embedding.image>
                                                <a class="grouped_elements" rel="images"
                                                   href="attachments/${embedding.filename}">
                                                    <img src="attachments/${embedding.filename}"
                                                         style="width: 100%"/>
                                                </a>
                                            <#else>
                                                <div class="row border border-top-0 border-left-0 border-right-0">
                                                    <div class="col-1">
                                                    </div>
                                                    <div class="col-11 text-left">
                                                        <pre>${embedding.data?html}</pre>
                                                    </div>
                                                </div>
                                            </#if>
                                        </div>
                                    </div>
                                </#list>
                            </#list>
                        </div>

                        <div class="container" style="opacity: 0.5;">
                            <#list element.after as after>
                                <div class="row border border-top-0 border-left-0 border-right-0">
                                    <div class="col-1 text-left">
                                        <span class="text-secondary"><nobr>After</nobr></span>
                                    </div>
                                    <div class="col-7 text-left">
                                        <i>${after.glueMethodName}</i>
                                    </div>
                                    <div class="col-2 text-left">
                                        <nobr>${after.result.returnDurationString()}</nobr>
                                    </div>
                                    <div class="col-2 text-left">
                                        <#if after.failed>
                                            <#assign class = "text-danger" />
                                        <#elseif after.skipped/>
                                            <#assign class = "text-warning" />
                                        <#else/>
                                            <#assign class = "text-success" />
                                        </#if>
                                        <span class="${class}">${after.status.statusString}</span>
                                    </div>
                                </div>
                                <#if after.failed>
                                    <div class="row border border-top-0 border-left-0 border-right-0">
                                        <div class="col-12 text-left">
                                            <code>${after.result.errorMessage?html}</code>
                                        </div>
                                    </div>
                                </#if>
                                <#list after.embeddings as embedding>
                                    <div class="row border border-top-0 border-left-0 border-right-0">
                                        <div class="col-12 text-left">
                                            <#if embedding.image>
                                                <a class="grouped_elements" rel="images"
                                                   href="attachments/${embedding.filename}">
                                                    <img src="attachments/${embedding.filename}"
                                                         style="width: 100%"/>
                                                </a>
                                            <#else>
                                                <div class="row border border-top-0 border-left-0 border-right-0">
                                                    <div class="col-1">
                                                    </div>
                                                    <div class="col-11 text-left">
                                                        <pre>${embedding.data?html}</pre>
                                                    </div>
                                                </div>
                                            </#if>
                                        </div>
                                    </div>
                                </#list>
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<#include "../../snippets/footer.ftl">
<#include "../../snippets/js.ftl">

</body>
</html>