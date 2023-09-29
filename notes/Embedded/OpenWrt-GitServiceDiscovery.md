# Setting Up OpenWRT Configuration Backup to GitLab

When you're working with OpenWRT, having a configuration backup is critical. Today, we're going to look at how to set up an automatic backup of your OpenWRT configuration to GitLab.

## Using a Script

The backbone of this process is a [script](https://github.com/dzianisv/utils/blob/9e4e60b40bd8f9628733c217eb41965cda9b8fee/bin/openwrt-configure-configuration-backup.sh#L48) designed to automatically backup the `/etc/config` directory.

## GitLab's Repo-Specific Authentication Tokens

One of the tools that make this process easier is GitLab's feature allowing you to generate authentication tokens for a specific repository. This feature lets us generate a Git remote URL with an embedded token in this format: `https://hello:$TOKEN@gitlab.com/$ORG/router-config.git`. This unique URL will be our gateway to backing up the router configuration.

![GitLab's Repo-Specific Authentication Tokens](../img/43c85410-080e-443f-bc41-ad8dfcbec5f2.webp)

## Configuration Availability

Your router configuration will now be readily available on GitHub for you to access, review, and manage as needed.

![Configuration Availability](../img/d469d44b-f4e8-4d11-937b-9633b0bcfe66.webp)

## Editing Configuration on GitLab

An added benefit is that the router configuration can be edited directly on GitLab using its built-in editor. This can be handy in some cases, but we advise you to exercise caution. Misconfigurations can lead to complications, including the possibility of rendering your router non-functional.

![Editing Configuration on GitLab](../img/5646128b-6d10-4132-bbbe-fadc769845d2.webp)

So there you have it! A straightforward way to set up automatic backups for your OpenWRT configuration to GitLab, providing an extra layer of security and convenience. Keep in mind that editing configurations directly on GitLab should be approached with care, despite its ease and accessibility. Happy routing!
