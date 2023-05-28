for $x in doc("parc.xml")/parc/espectacles/zona/espectacle/horari/passi
where $x/horaInici='12:30'
return concat('Total passis que comencen a les 12:30: ', count($x/horaInici))