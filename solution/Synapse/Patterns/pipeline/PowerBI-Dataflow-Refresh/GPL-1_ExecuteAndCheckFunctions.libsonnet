
function(GenerateArm="false",GFPIR="", SparkPoolName = "")
local Wrapper = import '../static/partials/wrapper.libsonnet';
local ParentPipelineTemplate = import '../static/partials/ParentPipeline.libsonnet';
local Name = if(GenerateArm=="false") 
			then "GPL_"+"ExecuteAndCheckFunctions"+"_"+GFPIR 
			else "[concat(parameters('dataFactoryName'), '/','GPL_"+"ExecuteAndCheckFunctions"+"_" + "', parameters('integrationRuntimeShortName'))]";
local CalledPipelineName = if(GenerateArm=="false") 
			then "GPL_"+"ExecuteAndCheckFunctions"+ "_Primary_"+GFPIR 
			else "[concat('GPL_"+"ExecuteAndCheckFunctions"+"_Primary_" + "', parameters('integrationRuntimeShortName'))]";
local Folder =  if(GenerateArm=="false") 
					then "ADS Go Fast/Data Movement/ExecuteAndCheckFunctions/" + GFPIR +"/ErrorHandler/"
					else "[concat('ADS Go Fast/Data Movement/ExecuteAndCheckFunctions/', parameters('integrationRuntimeShortName'), '/ErrorHandler/')]";

local pipeline = {} + ParentPipelineTemplate(Name, CalledPipelineName, Folder);
	
Wrapper(GenerateArm,pipeline)+{}