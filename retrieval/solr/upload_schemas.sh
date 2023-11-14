#!/bin/bash

# Delete cores
curl -X POST "http://localhost:8983/solr/admin/cores?action=UNLOAD&core=tracks_initial&deleteIndex=true&deleteDataDir=true&deleteInstanceDir=true"
curl -X POST "http://localhost:8983/solr/admin/cores?action=UNLOAD&core=tracks_refined&deleteIndex=true&deleteDataDir=true&deleteInstanceDir=true"

# Upload schemas
docker exec -it -u root versevault-solr sh -c "rm -rf /opt/solr/server/solr/configsets/_tracks_initial && cp -r /data/_tracks_initial/ /opt/solr/server/solr/configsets/ && chown -R solr:solr /opt/solr/server/solr/configsets/_tracks_initial"
docker exec -it -u root versevault-solr sh -c "rm -rf /opt/solr/server/solr/configsets/_tracks_refined && cp -r /data/_tracks_refined/ /opt/solr/server/solr/configsets/ && chown -R solr:solr /opt/solr/server/solr/configsets/_tracks_refined"

# Create cores
docker exec -it versevault-solr bin/solr create_core -c tracks_initial -d _tracks_initial
docker exec -it versevault-solr bin/solr create_core -c tracks_refined -d _tracks_refined
