<template>
  <app-header v-if="showHeader" />
  
  <main class="main-content">
    <router-view/>
  </main>
</template>

<script setup>
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import AppHeader from './components/AppHeader.vue'; // Importa nosso novo componente

const route = useRoute();

// Uma propriedade computada que verifica o meta da rota atual
// Retorna 'false' se a rota tiver hideHeader: true, e 'true' caso contrário
const showHeader = computed(() => !route.meta.hideHeader);
</script>

<style>
/* Podemos adicionar um estilo global para o conteúdo principal, se quisermos */
.main-content {
  /* O padding já é controlado pela classe #app no main.css, então isso é opcional */
  width: 100%;
}
</style>