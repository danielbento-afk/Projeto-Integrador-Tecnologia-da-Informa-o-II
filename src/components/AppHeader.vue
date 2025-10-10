<template>
  <header class="app-header">
    <div class="header-container">
      <div class="logo">
        <router-link to="/dashboard">Hora Certa</router-link>
      </div>
      <nav class="main-nav">
        <ul>
          <li><router-link to="/courses">Cursos</router-link></li>
          <li><router-link to="/availability">Disponibilidade</router-link></li>
          <li><router-link to="/schedule">Cronograma</router-link></li>
          <li><router-link to="/reports">Relatórios</router-link></li>
          <li><router-link to="/profile">Perfil</router-link></li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script setup>
// Nenhuma lógica de script necessária para este componente simples
</script>

<style scoped>
.app-header {
  background-color: white;
  box-shadow: 0 2px 8px var(--shadow-light);
  padding: 0 calc(var(--spacing-unit) * 2);
  width: 100%;
  position: sticky; /* Mantém o header fixo no topo ao rolar a página */
  top: 0;
  z-index: 1000;
  margin-bottom: calc(var(--spacing-unit) * 2); /* Espaço abaixo do header */
}

.header-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 70px; /* Altura do header */
}

.logo a {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--primary-color);
  text-decoration: none;
}

.main-nav ul {
  list-style: none;
  display: flex;
  gap: calc(var(--spacing-unit) * 2);
  margin: 0;
  padding: 0;
}

.main-nav a {
  text-decoration: none;
  color: var(--text-color-dark);
  font-weight: 500;
  padding: 10px 0;
  position: relative;
  transition: color 0.2s ease;
}

.main-nav a::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background-color: var(--primary-color);
  transition: width 0.3s ease;
}

.main-nav a:hover {
  color: var(--primary-color);
}

.main-nav a:hover::after,
.main-nav a.router-link-exact-active::after {
  width: 100%; /* Linha de destaque no item ativo/hover */
}

.main-nav a.router-link-exact-active {
  color: var(--primary-color);
  font-weight: 600;
}

/* Responsividade para o menu */
@media (max-width: 768px) {
  .main-nav {
    display: none; /* Em um projeto real, aqui entraria um menu "hambúrguer" */
  }
}
</style>