    <!--backstage-index end-->
          <script type="text/javascript">
        $(document).ready(function() {

            $('.nav_btn').click(function() {
                $('.mobile_nav_items').toggleClass('active');
            });

            $('.menu-btn').click(function(e) {
                e.preventDefault();
                $(this).next().slideToggle();
            });


        });
    </script>
    </body>
    </html>