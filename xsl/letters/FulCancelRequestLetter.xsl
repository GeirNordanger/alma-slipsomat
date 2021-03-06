<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
<xsl:template match="/">
 <html>
  <head>
   <xsl:call-template name="generalStyle" />
  </head>
  <body>
<xsl:if test="/notification_data/request/resource_sharing_request_id != ''">
   <xsl:message terminate="yes">Resource Sharing Request - No automatic cancellation letter sent</xsl:message>
</xsl:if>
<xsl:if test="/notification_data/request/convertable_to_resource_sharing = 'true'">
   <xsl:message terminate="yes">Converted to resoruce sharing, no need for cancel message.</xsl:message>
</xsl:if>
   <xsl:attribute name="style">
    <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
   </xsl:attribute>

   <xsl:call-template name="head" /> <!-- header.xsl -->

   <div class="messageArea">
    <div class="messageBody">

     <xsl:call-template name="toWhomIsConcerned"/>
     <!-- mailReason.xsl -->

     <p>
      @@we_cancel_y_req_of@@ <xsl:value-of select="notification_data/request/create_date"/> @@detailed_below@@.
     </p>

     <ul>
      <li>
       <xsl:value-of select="notification_data/phys_item_display/author"/>:
       <xsl:value-of select="notification_data/phys_item_display/title"/> (<xsl:value-of select="notification_data/phys_item_display/edition"/><xsl:if test="notification_data/phys_item_display/edition != ''">&#160;</xsl:if><xsl:value-of select="notification_data/phys_item_display/publication_date"/>)

       <!-- <xsl:call-template name="recordTitle" />--><!-- recordTitle.xsl -->
      </li> 
     </ul>

     <p>
      <xsl:choose>
       <xsl:when test="notification_data/request/status_note = 'RequestedMaterialCannotBeLocated'">
        <em>
         <xsl:choose>
          <xsl:when test="notification_data/receivers/receiver/preferred_language = 'en'">
           Unfortunately the document could not be found at the shelf.
           It's still possible that there are copies in other libraries in Norway or elsewhere
           that we can borrow for you (free of charge).
           Please contact us using the email adress below if you want us to check this.
          </xsl:when>
          <xsl:otherwise>
           Dokumentet ble dessverre ikke funnet på hylla.
           Det kan imidlertid være det finnes eksemplarer ved andre bibliotek i Norge eller
           utlandet som vi kan få lånt inn.
           Kontakt oss på epostadressen under hvis du ønsker at vi skal sjekke dette for deg.
          </xsl:otherwise>
         </xsl:choose>
        </em>
       </xsl:when>
       <xsl:otherwise>
        @@reason_deleting_request@@:
        <em><xsl:value-of select="notification_data/request/status_note_display"/></em>
       </xsl:otherwise>
      </xsl:choose>
     </p>

     <xsl:if test="notification_data/request/note != ''">
      <p>
       @@request_note@@:
       <xsl:value-of select="notification_data/request/note"/>
      </p>
     </xsl:if>

     <xsl:if test="notification_data/request/system_notes != ''">
      <p>
       @@request_cancellation_note@@: <xsl:value-of select="notification_data/request/system_notes"/>
      </p>
     </xsl:if>

    </div>
   </div>
   <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
   <!--<xsl:call-template name="contactUs" />-->
  </body>
 </html>
 </xsl:template>
</xsl:stylesheet>