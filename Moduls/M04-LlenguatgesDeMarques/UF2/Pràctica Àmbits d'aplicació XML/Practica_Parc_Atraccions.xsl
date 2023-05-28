<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

<html>
  <head>
     <link rel="stylesheet" type="text/css" href="horariParc.css"/>
    <title>Horari CoperAventura S.A.</title>
  </head> 
  <body>
    <header class="capcalera"><img alt="logoParc" width="50" height="50">
      <xsl:attribute name="src">
      <xsl:value-of select="parc/@logo"/>
      </xsl:attribute>
      </img>
      <span class="nom"><xsl:value-of select="parc/@nom"/></span></header>
      <header class="dades">Obrim del <xsl:value-of select="parc/dates/dataObertura"/> al <xsl:value-of select="parc/dates/dataTancament"/></header>
      <header class="mes">Novembre</header>
    <section>
      <table>
        <tr>
          <xsl:for-each select="parc/horaris/mes[@nom='Juliol']/periode/diaSetmana">
            <th><xsl:value-of select="."/></th>
          </xsl:for-each>
        </tr>
        <xsl:for-each select="parc/horaris/mes[@nom='Novembre']/periode">
        <tr>
          <xsl:for-each select="diaSetmana">
            <td>
                <xsl:choose>
                    <xsl:when test="@horaObertura and @horaTancament and @diaMes">
                        <div class="dia"><xsl:value-of select="@diaMes"/></div>
                        <div><xsl:value-of select="@horaObertura"/> - <xsl:value-of select="@horaTancament"/></div>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test="@diaMes">
                            <div class="dia"><xsl:value-of select="@diaMes"/></div>
                            TANCAT
                        </xsl:when>
                      </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
          </xsl:for-each>
        </tr>
        </xsl:for-each>
      </table>
    </section>  
    <footer class="dades">
      <xsl:value-of select="parc/adreca"/><br/>
      <xsl:value-of select="parc/ciutat"/> - <xsl:value-of select="parc/pais"/><br/>
       web: <a>
        <xsl:attribute name="href">
          <xsl:value-of select="parc/paginaWeb"/>
        </xsl:attribute>
        <xsl:value-of select="parc/paginaWeb"/>
      </a>
    </footer>
</body>
</html>
</xsl:template>
</xsl:stylesheet>