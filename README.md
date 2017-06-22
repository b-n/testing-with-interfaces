# Testing with `Interface`

## Dev, Build and Test
    
    sfdx force:source:push
    sfdx force:apex:test:run

## Description of Files and Directories

`oldway` contains the older way of handling triggers and call outs
`newerway` contains a very simple trigger handler logic which simplifies the understanding of what is executed and when
`interfaceway` contains a way using interfaces to do testing - decoupling the trigger handler from the sync class
