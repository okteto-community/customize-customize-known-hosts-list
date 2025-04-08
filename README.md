# Custom Known Hosts for Okteto Pipelines

> This repository is provided by the community and Okteto does not officially support it.

## Overview

This repository helps you configure Okteto with predefined SSH host keys when your cluster has limited outbound connectivity, particularly when direct access to port 22 is restricted.

By default, Okteto uses `ssh-keyscan` to dynamically retrieve public SSH keys from source control servers, which requires outbound access on port 22. This repository provides an alternative solution by packaging a static `known_hosts` file within a custom pipeline runner image.

## Why Use This?

- **Security Requirements**: When your organization restricts outbound traffic to source control servers
- **Air-gapped Environments**: For clusters with limited or no internet connectivity
- **Compliance**: When you need to explicitly control which SSH keys are trusted

## Included Host Keys

The sample `known_hosts` file in this repository includes public SSH keys for:
- github.com
- gitlab.com
- bitbucket.org

## Setup Instructions

### 1. Customize Known Hosts (Optional)

Update the `known_hosts` file with your required SSH public keys.

### 2. Build and Push the Custom Image

Build the container image, setting `OKTETO_VERSION` to match your installed Okteto Platform version:

```bash
# Replace 1.31.0 with your Okteto version
docker build -t your-registry/pipeline-runner-custom-known-hosts:1.31.0 --build-arg=OKTETO_VERSION=1.31.0 .

# Push to your container registry
docker push your-registry/pipeline-runner-custom-known-hosts:1.31.0
```

### 3. Update Helm Configuration

Add the `installer` section to your Helm configuration file (e.g. `values.yaml`), specifying your custom image:

```yaml
installer:
  runner:
    repository: your-registry/pipeline-runner-custom-known-hosts
    tag: 1.31.0
```

### 4. Upgrade Your Okteto Installation

Apply the changes to your Okteto installation:

```bash
helm upgrade --install okteto okteto/okteto -f values.yaml
```

## Verification

After applying these changes, Okteto will use your static `known_hosts` list when cloning repositories during:
- UI operations
- `okteto pipeline` commands
- `okteto preview` commands

## Tested Versions
This community contribution was tested in Okteto 1.31.0

## Troubleshooting

If you encounter SSH key verification errors:
1. Verify your `known_hosts` file contains the correct and up-to-date keys
2. Ensure the custom image was successfully built and is being used by Okteto

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.
