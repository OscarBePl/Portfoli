for $x in doc("parc.xml")/parc/atraccions/zona/atraccio
where $x/intensitat='Forta' and $x/edatMinima>12
return data($x/@nom)