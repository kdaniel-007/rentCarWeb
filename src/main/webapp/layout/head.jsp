<%-- 
    Document   : head
    Created on : 16 nov 2025, 14:52:03
    Author     : kdaniel
--%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RentCar - Sistema de Gestión</title>
<script src="https://cdn.tailwindcss.com"></script>
<script>
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    'primary-dark': '#0A2342',
                    'primary-accent': '#3b82f6', 
                    'text-dark': '#1F2937', 
                    'success': '#10B981', 
                    'warning': '#F59E0B', 
                    'danger': '#EF4444', 
                },
                fontFamily: {
                    sans: ['Inter', 'sans-serif'],
                }
            }
        }
    }
</script>
<style>
    .sidebar {
        transition: transform 0.3s ease-in-out;
    }
    .main-content {
        transition: margin-left 0.3s ease-in-out;
    }
    @media (max-width: 768px) {
        .sidebar.hidden-mobile {
            transform: translateX(-100%);
        }
    }
    .toggle-switch input:checked + .slider {
        background-color: #10B981;
    }
    .toggle-switch input:checked + .slider:before {
        transform: translateX(20px);
    }
    .slider {
        background-color: #ccc;
        transition: .4s;
    }
    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        border-radius: 34px;
    }
    .slider:before {
        position: absolute;
        content: "";
        height: 16px;
        width: 16px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        transition: .4s;
        border-radius: 50%;
    }
</style>
