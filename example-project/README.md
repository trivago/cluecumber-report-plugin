# cluecumber-test-project

Test project to simulate the behavior of Cluecumber - a Maven plugin that generates test reports from [Cucumber](https://cucumber.io) JSON files.

This test project always uses the latest Cluecumber version.

## Change plugin configuration

The whole plugin configuration is managed via the pom.xml file in this test project.

## Run the project

To run the project you need to have at least Java 8 and Maven 3.3.9 installed on your system.

Just run the Maven command ```mvn clean verify``` to see the runner and feature generation of Cucable in action.

The report is generated inside the `target` directory.