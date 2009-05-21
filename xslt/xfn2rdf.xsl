<?xml version="1.0" encoding="UTF-8"?>
<!--
 -
 -  $Id: xfn2rdf.xsl,v 1.3 2009-05-12 21:45:31 source Exp $
 -
 -  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
 -  project.
 -
 -  Copyright (C) 1998-2009 OpenLink Software
 -
 -  This project is free software; you can redistribute it and/or modify it
 -  under the terms of the GNU General Public License as published by the
 -  Free Software Foundation; only version 2 of the License, dated June 1991.
 -
 -  This program is distributed in the hope that it will be useful, but
 -  WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 -  General Public License for more details.
 -
 -  You should have received a copy of the GNU General Public License along
 -  with this program; if not, write to the Free Software Foundation, Inc.,
 -  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet
    xmlns:xsl  ="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xfn  ="http://gmpg.org/xfn/11#"
    xmlns:foaf ="http://xmlns.com/foaf/0.1/"
    xmlns:h    ="http://www.w3.org/1999/xhtml"
    xmlns:rdf  ="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    >
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="baseUri" />

    <xsl:variable name="xfn-rel">
	<xfn>
	    <rel value="contact"/>
	    <rel value="acquaintance"/>
	    <rel value="friend"/>
	    <rel value="met"/>
	    <rel value="co-worker"/>
	    <rel value="colleague"/>
	    <rel value="co-resident"/>
	    <rel value="neighbor"/>
	    <rel value="child"/>
	    <rel value="parent"/>
	    <rel value="sibling"/>
	    <rel value="spouse"/>
	    <rel value="kin"/>
	    <rel value="muse"/>
	    <rel value="crush"/>
	    <rel value="date"/>
	    <rel value="sweetheart"/>
	    <rel value="me"/>
	</xfn>
    </xsl:variable>
    <xsl:variable name="doc" select="/html"/>

    <xsl:template match="html">
	<rdf:RDF>
	    <xsl:variable name="xfn-doc">
		<xsl:for-each select="$xfn-rel/xfn/rel">
		    <xsl:variable name="rel" select="@value"/>
		    <xsl:for-each select="$doc//a">
			<xsl:variable name="rel-attr" select="concat(' ', @rel, ' ')"/>
			<xsl:if test="contains ($rel-attr, concat(' ', $rel, ' '))">
			    <xsl:element name="{$rel}" namespace="http://gmpg.org/xfn/11#">
				<rdf:Description>
				    <foaf:homepage rdf:resource="{@href}"/>
				</rdf:Description>
			    </xsl:element>
			</xsl:if>
		    </xsl:for-each>
		</xsl:for-each>
	    </xsl:variable>
	    <xsl:if test="$xfn-doc/*">
		<rdf:Description rdf:about="{$baseUri}">
		    <foaf:homepage rdf:resource="{$baseUri}"/>
		    <xsl:copy-of select="$xfn-doc"/>
		</rdf:Description>
	    </xsl:if>
	</rdf:RDF>
    </xsl:template>

</xsl:stylesheet>
