# Deployment customizations

The [Jira Software](jira/azuredeploy.json), [Jira Service Desk](servicedesk/azuredeploy.json), and [Confluence](confluence/azuredeploy.json) templates in this repository provide common parameters for customizing your deployment.

## Basic customizations

You can configure these settings through the available Azure Marketplace interface *or* through a _custom parameters template_ during a CLI deployment.

### Custom domain name

Azure doesn't register domain names, so you'll have to secure yours through a separate vendor. You can set your custom domain name through the Azure Marketplace templates allow in the *Configure Domain* step.

For CLI deployments, use the `cname` parameter:

```
    {
        "parameters": {
            "cname": {
                "value": "mycustomdomainname.com"
            }
        }
    }
```

### SSL

From the Azure Marketplace templates, you can enable HTTPS/SSL and configure it through the *Configure Domain* step. There, you'll be asked to provide a _Base64-encoded PFX certificate_ and its corresponding password.

For CLI deployments, use the `sslBase64EncodedPfxCertificate` and `sslPfxCertificatePassword` parameters:

```
    {
        "parameters": {
            "sslBase64EncodedPfxCertificate": {
                "value": "-----BEGIN CERTIFICATE-----MIIF2zCCBMOgAwIBAgIQMj8HjgweXkb..."
            }
            "sslPfxCertificatePassword": {
                "value": "Myazurepassword1!"
            }
        }
    }
```

## Advanced customizations

You can only configure the following customizations through the CLI.

### Linux Distribution

By default, our templates will deploy your chosen product on [Ubuntu 16.04 LTS](https://wiki.ubuntu.com/XenialXerus/ReleaseNotes). You can override this with the following Linux distributions (all supported):

- "Canonical:UbuntuServer:18.04-LTS",
- "RedHat:RHEL:7.5",
- "OpenLogic:CentOS:7.5",
- "credativ:Debian:9-backports"

To use any of these distributions, set the `linuxOsType` parameter. For example, to use Red Hat Enterprise Linux 7.5:

```
    {
        "parameters": {
            "linuxOsType": {
                "value": "RedHat:RHEL:7.5"
            }
        }
    }
```
