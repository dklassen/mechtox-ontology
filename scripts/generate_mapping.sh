#! /bin/bash

########################################################
# Description ::  Script to generate mapping of mechtox 
# ontology to other ontology. This script relies on the 
# fact that relations between classes in external
# ontologies were made using the 'seeAlso' annotation
# created in the Protege OWL ontology editor software.
# The script depends on the ontology being saved in turtle
# format.
# Author :: Dana Klassen
########################################################

# Covert the ontology to ntriples
rapper -e -q -i turtle ../MechTox.owl > ../tmp_mechtox.nt
# extract lines containing seeAlso predicate
grep seeAlso ../tmp_mechtox.nt > ../mechtox_mapping.nt
#remove tmp file
rm ../tmp_mechtox.nt
#remove quotes because of the annotation and replace with <>
sed -i0 's/"h/<h/g' ../mechtox_mapping.nt
sed -i0 's/"@en \./> \./g' ../mechtox_mapping.nt
sed -i0 's/" \./> \./g' ../mechtox_mapping.nt

#replace see also with owl:equivalentClass
sed -i0 's/<http\:\/\/www\.w3\.org\/2000\/01\/rdf-schema#seeAlso>/<http:\/\/www\.w3\.org\/2002\/07\/owl#equivalentClass>/g' ../mechtox_mapping.nt
