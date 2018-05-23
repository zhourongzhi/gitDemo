<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>


<jsp:directive.include file="includes/top.jsp" />

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>


<div class="box" id="login" style="width:20%;margin-left:40%;margin-right:40%">
  <form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">

    <form:errors path="*" id="msg" cssClass="errors" element="div" htmlEscape="false" />
  
    <h2></h2>
  
    <section class="row">
      <label for="username">账号</label>
      <c:choose>
        <c:when test="${not empty sessionScope.openIdLocalId}">
          <strong>${sessionScope.openIdLocalId}</strong>
          <input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
        </c:when>
        <c:otherwise>
          <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
          <form:input cssClass="required" cssErrorClass="error" id="username" size="25" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="off" htmlEscape="true" />
        </c:otherwise>
      </c:choose>
    </section>
    
    <section class="row">
      <label for="password">密码</label>
      <%--
      NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
      "autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
      information, see the following web page:
      http://www.technofundo.com/tech/web/ie_autocomplete.html
      --%>
      <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
      <form:password cssClass="required" cssErrorClass="error" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
    </section>
    
    <section class="row check">
      <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
      <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
    </section>
    
    <section class="row btn-row">
      <input type="hidden" name="lt" value="${loginTicket}" />
      <input type="hidden" name="execution" value="${flowExecutionKey}" />
      <input type="hidden" name="_eventId" value="submit" />


      <input class="btn-submit" name="submit1" accesskey="l" value="登录" tabindex="4" type="submit" />
      <input class="btn-reset" name="reset" accesskey="c" value="重置" tabindex="5" type="reset" />

      <input type="hidden" id="loginType" value="0" name="loginType" />
      <input type="hidden" id="openId" value="" name="openId" />

      <input class="btn-reset"  accesskey="c" value="微信登录" tabindex="5" type="button" onclick="showWxLogin()" />
    </section>
  </form:form>

</div>
  
<div id="sidebar">
  <div class="sidebar-content">
    <p style="display:none"><spring:message code="screen.welcome.security" /></p>
    
  </div>
</div>



<script type="text/javascript">

  /**
   *关闭窗口回调事件
   */

  function callBack(){
    window.clearInterval(timer)
    console.log("newWindow..."+newWindow.closed);

    var openId=newWindow.document.getElementById("openId").value;//openId
    var loginName=newWindow.document.getElementById("loginName").value;//登录名称
    var rowCount=newWindow.document.getElementById("rowCount").value;//是否有记录
   //  openId="oTuZNxOKWwy6DaC3-RV_pTcMOdUY";
    document.getElementById("openId").value=openId;
    document.getElementById("username").value=loginName;
    document.getElementById("loginType").value=1;

    console.log("form---->username:"+document.getElementById("username").value);

    if(rowCount==0){
       alert("账号不存在");
       return ;
    }else{
       $("form").submit();
    }


    //document.getElementById("fm1").submit();
  }

  /**
   * 检测窗口是否关闭
   */
  function checkNewWindowClosed() {
    if (newWindow.closed == true) {
      callBack();
    }
  }

  /**
   * 呈现微信扫描登录页面
   */
  function showWxLogin(){
    var iTop = (window.screen.availHeight - 30 - 600) / 2;
    var iLeft = (window.screen.availWidth - 10 - 800) / 2;
    var url="https://open.weixin.qq.com/connect/qrconnect?appid=wx242f65c58fd5929e&redirect_uri=http://ydjr.dev.chengyiwm.com/authority-mgr/view/wxLogin&response_type=code&scope=snsapi_login&state=state#wechat_redirect";
   // url="http://ydjr.dev.chengyiwm.com/authority-mgr/wxLogin.jsp";
    newWindow= window.open(url,
                    'newwindow',
                    'height=600, width=800, top='
                    + iTop
                    + ',left='
                    + iLeft
                    + ', toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
    timer=window.setInterval("checkNewWindowClosed()",500);

  }


</script>



<jsp:directive.include file="includes/bottom.jsp" />
