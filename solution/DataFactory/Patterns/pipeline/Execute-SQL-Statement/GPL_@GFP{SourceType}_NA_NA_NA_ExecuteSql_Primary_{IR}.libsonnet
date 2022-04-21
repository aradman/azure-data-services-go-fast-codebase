function(GenerateArm="false",GFPIR="Azure",SourceType="SqlServerTable",SourceFormat="NA", TargetType="NA", TargetFormat="NA")

local generateArmAsBool = GenerateArm == "true";
local Wrapper = import '../static/partials/wrapper.libsonnet';

local typePropertiesforlookup = import './partials/Main_Lookup.libsonnet';

local name =  if(!generateArmAsBool) 
			then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_CDC_" + "Primary_" + GFPIR 
			else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_CDC_Primary_" + "', parameters('integrationRuntimeShortName'))]";

local Folder =  if(GenerateArm=="false") 
					then "ADS Go Fast/Data Movement/SQL-Database-to-Azure-Storage-CDC/" + GFPIR + "/"
					else "[concat('ADS Go Fast/Data Movement/SQL-Database-to-Azure-Storage-CDC', parameters('integrationRuntimeShortName'), '/')]";


local pipeline = 
{
    "name": name,
    "properties": {
        "activities": [
            {
                "name": "ExecuteSQLStatement",
                "type": "Lookup",
                "dependsOn": [],
                "policy": {
                    "timeout": "7.00:00:00",
                    "retry": 0,
                    "retryIntervalInSeconds": 30,
                    "secureOutput": false,
                    "secureInput": false
                },
                "userProperties": [],
                "typeProperties": typePropertiesforlookup(GenerateArm, GFPIR,SourceType)
            }
        ],
        "parameters": {
            "TaskObject": {
                "type": "object",
                "defaultValue": {}
            }
        },
        "folder": {
            "name": Folder
        },
        "annotations": [],
        "lastPublishTime": "2022-03-27T00:15:57Z"
    },
    "type": "Microsoft.DataFactory/factories/pipelines"
};
Wrapper(GenerateArm,pipeline)+{}