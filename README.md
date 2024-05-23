# AzureDevOpsPipelines-Tips

This demo shows how to deploy infrastructure into Azure using Terraform and Azure DevOps Yaml pipelines.

The video explaining the different steps is available here:

<img width="60%" src="https://i.ytimg.com/vi/ukmbiTSWU_M/maxresdefault.jpg">
<a href="https://youtu.be/ukmbiTSWU_M">https://youtu.be/ukmbiTSWU_M</a>
</img>

# Srinivasan Notes

the Skip-Step was originaaly from author and it was not working due to outdated commands
So use main.tf file from the root directory

Preerq:
1. create the storage account as terraform-resource-group
2. Create container as terraformtfstatesrgovin
3. install checkov to scan terraform codes