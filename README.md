# Terraform Playroom/Einarbeitung
This is a personal playroom/Einarbeitungsraum for Jon to get to grips with Terraform.
Within this will be helpful notes and explanations of Terraform quirks and syntax.

## What is Terraform?
Terraform is an infrastructure as code tool that lets you build, change, and version cloud and on-prem resources safely and efficiently.

Terraform is what is known as a declaritive language.
> ... a style of building the structure and elements of computer programs—that expresses the logic of a computation without describing its control flow.

In laymens this means that we do not need to tell Terraform to build a connection to the cloud providor's API and follow it up with specific instructions of what we want to setup.

We **declare** to Terraform what we want to have, give it all the settings and configuration it needs, and it goes off and builds that what we want.
> Instead of a set of instructions, it's more of a wish list or "order sheet".

## With what providers can Terraform work with?
The follow is a list of providers on which Terraform can provision services.
<details open>
  <summary>List of Providers</summary>
Amazon Web Services, Cloudflare, Microsoft Azure, IBM Cloud, Serverspace, Selectel, Google Cloud Platform, DigitalOcean, Oracle Cloud Infrastructure, Yandex.Cloud, VMware vSphere, OpenStack.
</details>

