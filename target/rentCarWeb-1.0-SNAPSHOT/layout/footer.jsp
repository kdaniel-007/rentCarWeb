<%-- 
    Document   : footer
    Created on : 16 nov 2025, 14:54:00
    Author     : kdaniel
--%>
</div> 
</main> 
</div> 

<script>
    document.getElementById('menuToggle').addEventListener('click', function () {
        const sidebar = document.getElementById('sidebar');

        sidebar.classList.toggle('hidden-mobile');

        if (window.innerWidth < 768) {
            if (!sidebar.classList.contains('hidden-mobile')) {
                sidebar.classList.remove('-translate-x-full');
            } else {
                sidebar.classList.add('-translate-x-full');
            }
        }
    });

    window.addEventListener('resize', function () {
        const sidebar = document.getElementById('sidebar');
        if (window.innerWidth >= 768) {
            sidebar.classList.remove('hidden-mobile');
            sidebar.classList.remove('-translate-x-full');
        } else {
            if (!sidebar.classList.contains('hidden-mobile')) {
                sidebar.classList.add('hidden-mobile');
            }
        }
    });

    window.onload = function () {
        const sidebar = document.getElementById('sidebar');
        if (window.innerWidth < 768) {
            sidebar.classList.add('hidden-mobile');
            sidebar.classList.add('-translate-x-full');
        }
    }

    document.querySelectorAll('.modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', function (e) {
            if (e.target === overlay) {
                overlay.classList.add('hidden');
            }
        });
    });
</script>
</body>
</html>