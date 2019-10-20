# balena-raspberry-pi4-omada-controller
An Omada Controller Docker container built for an ARM64v8 (aarch64) Raspberry Pi4 using Balena

This image makes use of omada-controller_3.2.1-1_all.deb made by the TP-link community available with the following link:
https://community.tp-link.com/en/business/forum/topic/162210

***
THIS IS NOT A FULLY AUTOMATED BUILD!

The Oracle JDK License has changed for releases starting April 16, 2019.
The new [Oracle Technology Network License Agreement for Oracle Java SE](https://hub.docker.com/technetwork/java/javase/terms/license/javase-license.html) is substantially different from prior Oracle JDK licenses. The new license permits certain uses, such as personal use and development use, at no cost -- but other uses authorized under prior Oracle JDK licenses may no longer be available. Please review the terms carefully before downloading and using this product. Please [review the FAQ](https://www.oracle.com/technetwork/java/javase/overview/oracle-jdk-faqs.html) for more information.

Commercial license and support is available with a low cost [Java SE Subscription](https://www.oracle.com/java/java-se-subscription.html).

Oracle also provides the latest OpenJDK release under the open source [GPL License](https://openjdk.java.net/legal/gplv2+ce.html) at [jdk.java.net](https://jdk.java.net/).

Reference: https://hub.docker.com/_/oracle-serverjre-8

***

## Docker compose service
```
omada:
    build: ./omada
    container_name: omada-controller
    privileged: true
    network_mode: host
    volumes:
        - omada-data:/opt/tplink/OmadaController/data
        - omada-work:/opt/tplink/OmadaController/work
        - omada-logs:/opt/tplink/OmadaController/logs
    ports:
        - 8088:8088
        - 8043:8043
    restart: unless-stopped
```

## Components
  * Omada Controller 3.2.1
  * Java ORACLE 1.8.0 JDK
  * MongoDB v2.6.10

## Usage

### 1. Clone this repository
```
git clone https://github.com/HDebeuf/balena-raspberry-pi4-omada-controller.git
```

### 2. Download Java Oracle 1.8.0 JDK
Go on the official Oracle website in order to download the [Java Oracle 1.8.0 JDK](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).
You'll have to accept the license aggreements and create a personnal account.

### 3. Add the Java Oracle JDK in the project
Rename the downloaded JDK to `java_jdk.tar.gz` and place it in the project folder

### 4. Define your email variable
In order to download the `omada-controller_3.2.1-1_all.deb` install file, your email is required in order to access anonymously 'ftp.rent-a-guru.de'

```
ENV OMADA_EMAIL_ADDRESS your@email.com
```

### 5. Upload your image to Balena
Follow the [Balena documentation](https://www.balena.io/docs/learn/deploy/deployment/) to push your image to your Raspberry Pi 4.
!! It takes approximatelly 5 minutes to upload your source package to balena cloud due to the heavy Java JDK .tar.gz file

```
cd ProjectFolder
balena push ProjectName --emulated
```

!! Omada may throw a Java error on first run due to the volume creation. Simply retry the push

### 6. Configure Omada controller
Configure your Omada Controller following the [setup tutorial](https://www.tp-link.com/us/support/download/eap-controller/).

## Alternative
In order to reduce build time, you may upload the Java JDK on a personnal download link and let the container process it by himself during build.

Simply add your download link to the `Dockerfile_wget_java_jdk` file and rename it to `Dockerfile`.
```
ENV OMADA_JAVA_JDK_DOWNLOAD_URL https://add-your-link-here.com
```

You may use a OneDrive link for example -> https://unix.stackexchange.com/questions/223734/how-to-download-files-and-folders-from-onedrive-using-wget
