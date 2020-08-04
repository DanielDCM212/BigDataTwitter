# BigDataTwitter

## Tools:
[![Java](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=Ubuntu&logoColor=orange&labelColor=101010)]()
[![VsCode](https://img.shields.io/badge/VsCode-007396?style=for-the-badge&logo=Visual-Studio-Code&logoColor=white&labelColor=101010)]()
[![Python](https://img.shields.io/badge/Python-3DDC84?style=for-the-badge&logo=python&logoColor=yellow&labelColor=101010)]()
[![GNU Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=GNU-Bash&logoColor=white&labelColor=101010)]()
[![Java](https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=java&logoColor=red&labelColor=101010)]()


## Infrastructure:
[![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=orange&labelColor=101010)]()
[![Confluent Kafka](https://img.shields.io/badge/Kafka-999999?style=for-the-badge&logo=Apache-Kafka&logoColor=white&labelColor=101010)]()
[![ElsaticStack](https://img.shields.io/badge/Elastic-Stack-FCD109?style=for-the-badge&logo=Elastic&logoColor=F04E98&labelColor=101010)]()
[![ElsaticSearch](https://img.shields.io/badge/Elastic-Search-3EBFB3?style=for-the-badge&logo=Elasticsearch&logoColor=FCD109&labelColor=101010)]()
[![Kibana](https://img.shields.io/badge/Kibana-F04E98?style=for-the-badge&logo=kibana&logoColor=3EBFB3&labelColor=101010)]()
[![Logstash](https://img.shields.io/badge/Logstash-1D77CC?style=for-the-badge&logo=Logstash&logoColor=white&labelColor=101010)]()

El objetivo de este proyecto es mostrar lo aprendido durante el quinto cuatrimestre en la materia **BigData**, como proyecto desarrollamos un pipeline por el cual minamos datos de Twitter mediante la libreria [Twint]() los ingestamos en un topico de  [kafka Confluent](), para posteriormente enriquecer los datos mediante python asi mismo ingestarlos a un nuevo topico para su indexacion en [ElasticSearch]() usando como intermediario [Logstash]() y como componente final usariamos [Kibana]() para la visualizacion de datos.

## Como acontinuacion se muestra en la imagen:
![Pipeline](img/Service.png)


Para facilitar la instalacion decidimos crear un instalador programado en bash para acelerar la instalacion y el despliege en los nodos o clusters.

## Instrucciones de Instalacion

git clone https://github.com/DanielDCM212/BigDataTwitter.git

cd BigDataTwitter

bash InstallHub.sh

## Ejecucion del programa