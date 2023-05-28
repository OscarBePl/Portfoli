for $x in doc("parc.xml")/parc/atraccions/zona/atraccio
where $x/edatMinima<11
return concat('Nom atracció: ', data($x/@nom))