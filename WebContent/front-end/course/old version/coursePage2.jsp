<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- ========== CSS Area ========== -->
    <!-- Bootstrap 的 CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- 自己的 CSS 一定放在最下面 -->
    <!--     <link rel="stylesheet" href="css/course.css"> -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/course/css/course.css">
    <!-- ========== CSS Area ========== -->

    <title>課程使用頁面</title>
</head>

<body>
    <!-- include 前台頁面的 header -->
    <jsp:include page="/index/front-index/header.jsp" />

    <main>
        <section id="videoView">
            <div class="jumbotron">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- 麵包屑 -->
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">所有課程</a></li>
                                    <li class="breadcrumb-item"><a href="#">氣壓學</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">${courseVO.coursename}</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <!-- 課程名稱 -->
                            <h1>課程名稱 - ${courseVO.coursename}</h1>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8" id="videoplayarea">
                            <!-- 影片播放 -->
                            <video id="coursePlayer" width="100%" height="auto" autoplay controls>
                                <!--                                 <source src="Nyan_Cat.mp4" type="video/mp4">萬一瀏覽器未支援時顯示訊息 -->
                                <source src="<%=request.getContextPath()%>/front-end/course/Nyan_Cat.mp4"
                                    type="video/mp4">萬一瀏覽器未支援時顯示訊息
                            </video>
                        </div>
                        <div class="col-md-4">
                            <!-- 單元選擇欄位 -->
                            <div>
                                <h2>第 1 / 10 單元 </h2>
                            </div>
                            <div class="list-group" id="videolist">
                                <!-- 影片列表擺放區塊 -->
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-2 courseInfo">
                            <!-- 須要查詢訂單中的購買人次 -->
                            <p>8787</p>
                            <p>位同學</p>
                        </div>
                        <div class="col-sm-2 courseInfo">
                            <!-- 須要video中的課程的時間加總 -->
                            <p id="ttltime"> ${courseVO.ttltime} </p>
                            <p>分鐘</p>
                        </div>
                        <div class="col-sm-2 courseInfo">
                            <!-- 須要video中的課程的時間加總 -->
                            <p>課程評價</p>
                            <p> ${courseVO.csscore / courseVO.csscoretimes} </p>
                        </div>
                        <div class="col-sm-3 courseInfo">
                            <!-- 須要查詢原本單價、類別、優惠活動 -->
                            <p>售價</p>
                            <p id="courseprice"> ${courseVO.courseprice} </p>
                        </div>
                        <div class="col-sm-3 courseInfo">
                            <!-- 須要查詢該使用者是否已加入收藏、是否已購買 -->
                            <p>加入收藏</p>
                            <p>立即購買</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- <section id="courseStatus">
        <div class="container">
        </div>
    </section> -->

        <section>
            <div class="container">

                <nav class="nav nav-pills nav-fill" id="nav-subpage">
                    <a class="nav-item nav-link active"
                        href="<%=request.getContextPath()%>/front-end/course/subpage_courseinfo.html">課程簡介</a>
                    <a class="nav-item nav-link"
                        href="<%=request.getContextPath()%>/front-end/course/subpage_downloadfile.html">教材下載</a>
                    <a class="nav-item nav-link"
                        href="<%=request.getContextPath()%>/front-end/course/subpage_coursescope.html">課程評價</a>
                    <a class="nav-item nav-link"
                        href="<%=request.getContextPath()%>/front-end/course/subpage_post.html">問題討論</a>
                </nav>

                <div class="row">
                    <div class="col-md-12" id="subpage">
                        <p> Lorem ipsum dolor sit, amet consectetur adipisicing elit. Eius fugiat nam dicta. Numquam
                            ipsa maiores rem, culpa autem corrupti! Quos quis eos aliquam aut non, modi officiis dolor.
                            Eos ducimus rerum recusandae odio qui iusto, veritatis, ab ullam nemo beatae quasi
                            doloribus! Facere unde at corrupti nihil eveniet delectus animi rem, possimus sunt
                            praesentium? Optio nemo dignissimos voluptatibus facilis dolorem? Fuga nisi dolorem eligendi
                            optio, quisquam enim officiis facilis quibusdam repellendus explicabo illum accusantium
                            obcaecati aperiam, quod ab provident. Alias maiores, dolor recusandae dicta eveniet eius
                            nobis accusantium rem voluptatibus omnis, illum aliquid, temporibus eos cumque porro.
                            Necessitatibus inventore fuga alias culpa sit rem vel doloribus totam, ullam quisquam
                            maiores obcaecati, numquam ut sed impedit odit enim id quaerat quia accusamus! Saepe
                            architecto rerum quae modi fuga atque deserunt nobis numquam, molestias minus aut sit
                            officia optio quisquam voluptatum odit perspiciatis quam illum temporibus quas aliquid vitae
                            consequuntur. Ad sit amet aliquam enim est animi recusandae, asperiores, dolore cum officia
                            nemo eligendi optio eum consequuntur odit, quisquam reprehenderit modi iste obcaecati
                            corrupti praesentium voluptate exercitationem voluptates nesciunt? Cum ipsam qui molestias
                            tenetur? Qui iusto distinctio debitis porro impedit asperiores error dicta quod, illo
                            nesciunt laborum fuga repellendus quos vero itaque nobis tempora nihil, magni eligendi
                            cupiditate ratione quas sit vel alias! Voluptates, debitis harum! Nisi error earum nostrum
                            asperiores exercitationem natus ea a, magnam ab fugiat illum maiores harum debitis aliquid
                            explicabo rerum doloremque sapiente repudiandae quos officiis culpa. Officia, exercitationem
                            consequatur! Voluptatem nisi voluptate temporibus quaerat obcaecati qui quia iure
                            repudiandae porro architecto quisquam nam, a id ad velit placeat impedit eveniet ipsum ex in
                            voluptatum! Sed labore, voluptate, dicta accusamus, quis quia eaque non quaerat laudantium
                            praesentium repellat velit. Amet, in eaque! Inventore, nihil quidem repudiandae illo saepe
                            voluptatum praesentium cumque. Illum officiis eius exercitationem a quam repudiandae.</p>
                    </div>
                </div>

            </div>

        </section>
    </main>

    <!-- ========== JavaScript Area ========== -->
    <!-- Bootstrap 的 JS (jquery 改為完整版)-->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        // addEventListener('load',init());
        window.onload = init;

        function init() {
            // console.log("${courseVO.courseno}");
            $("#subpage").load('<%=request.getContextPath()%>/front-end/course/subpage_courseinfo.html');

            $.ajax({
                // url: "/EA103G5_1005_Re/ajax_pratice",
                url: "<%=request.getContextPath()%>/ajax_pratice",
                type: "POST",
                data: {
                    // courseno: "COUR0001"
                    courseno: "${courseVO.courseno}"
                },
                success: function (data) {
                    // console.log(data);
                    var videos = JSON.parse(data);
                    var txt = "";
                    for (let i = 0; i < videos.length; i++) {
                        txt +=
                            '<a href="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=' +
                            videos[i].videono +
                            '" class="list-group-item list-group-item-action list-group-item-primary"> 單元 ' +
                            videos[i].chapterno + "<br>" + videos[i].chaptername + '<br>單元長度：' + videos[i]
                            .chapterlen + ' 秒</a>';
                        // txt +=
                        //     '<button type="button" href="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=' +
                        //     videos[i].videono +
                        //     '" class="list-group-item list-group-item-action"> 單元 ' +
                        //     videos[i].chapterno + "<br>" + videos[i].chaptername + '</button>';
                        // txt += "<p>videono = " + videos[i].videono + "</p>";
                        // txt += "<p>courseno = " + videos[i].courseno + "</p>";
                        // txt += "<p>testscope = " + videos[i].testscope + "</p>";
                        // txt += "<p>chapterno = " + videos[i].chapterno + "</p>";
                        // txt += "<p>chaptername = " + videos[i].chaptername + "</p>";
                        // txt += "<p>chapterlen = " + videos[i].chapterlen + "</p>";
                        // txt += "<p>====================</p>";
                    }

                    $("#videolist").html(txt);

                    $("#videolist .list-group-item").click(function (e) {
                        e.preventDefault();
                        // ===== 方法一 =====
                        // let changeVideoSource = `<video width="100%" height="auto" autoplay controls>
                        //             <source src ="` + $(this).attr("href") + `" type = "video/mp4">
                        //             萬一瀏覽器未支援時顯示訊息 </video>`;
                        // $("#videoplayarea").html(changeVideoSource)

                        // ===== 方法二 =====
                        $("#videoplayarea video source").attr("src", $(this).attr("href"));
                        // console.log($("#videoplayarea video source").attr("src"));

                        // document.getElementById("coursePlayer").load();
                        // console.log($("#coursePlayer").duration + " Secs");
                        // console.log(document.getElementById("coursePlayer").duration + " Secs");

                        let videoPlayer = document.getElementById("coursePlayer");
                        videoPlayer.load();
                        console.log(videoPlayer.duration + " Secs");

                    });
                }
            });

            $("#nav-subpage .nav-item").click(function (e) {
                e.preventDefault();
                $("#nav-subpage .nav-item").removeClass("active");
                $(this).addClass("active");
                // console.log($(this).attr("href"));
                $("#subpage").load($(this).attr("href"));
            });

        };
    </script>

    <!-- include 前台頁面的 footer -->
    <jsp:include page="/index/front-index/footer.jsp" />
</body>

</html>