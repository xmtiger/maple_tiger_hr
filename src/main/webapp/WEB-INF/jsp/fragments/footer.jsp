<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="container">
    <hr>
    <footer>
        <p>&copy; Yamax.com 2017</p>
    </footer>
</div>

<script src="/resources/core/js/jquery.min.js"></script>

<spring:url value="/resources/core/js/bootstrap.min.js" var="bootstrapJs"/>

<script src="${bootstrapJs}"></script>