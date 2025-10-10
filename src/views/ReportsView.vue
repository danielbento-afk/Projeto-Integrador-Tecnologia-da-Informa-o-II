<template>
  <div class="container">
    <router-link to="/dashboard">&larr; Voltar para o Dashboard</router-link>
    <h1>Relatórios de Estudo</h1>

    <div class="report-section">
      <h2>Horas de Estudo por Disciplina (Semana)</h2>
      <div class="chart-container">
        <Bar v-if="chartData.datasets.length" :data="chartData" :options="chartOptions" />
      </div>
    </div>

    <div class="report-section stats-grid">
      <div class="stat-card">
        <h3>Total de Horas na Semana</h3>
        <p class="stat-number">25h</p>
      </div>
      <div class="stat-card">
        <h3>Disciplina Mais Estudada</h3>
        <p class="stat-text">Cálculo I</p>
      </div>
      <div class="stat-card">
        <h3>Meta Semanal</h3>
        <p class="stat-progress">83%</p>
        <small>(25h de 30h)</small>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

// Registra os componentes do Chart.js que vamos usar
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

const chartData = ref({
  labels: [],
  datasets: []
})

const chartOptions = ref({
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      display: false
    }
  },
  scales: {
    y: {
      beginAtZero: true,
      title: {
        display: true,
        text: 'Horas'
      }
    }
  }
})

// Simula o carregamento dos dados que viriam do backend
onMounted(() => {
  // Dados simulados de estudo
  const studyData = {
    'Cálculo I': 8,
    Física: 6,
    Algoritmos: 7,
    'Engenharia de Software': 4
  }

  chartData.value = {
    labels: Object.keys(studyData),
    datasets: [
      {
        label: 'Horas Estudadas',
        backgroundColor: ['#42b983', '#ff6384', '#36a2eb', '#ffce56'],
        data: Object.values(studyData)
      }
    ]
  }
})
</script>

<style scoped>
.report-section {
  background-color: #f9f9f9;
  border: 1px solid #eee;
  padding: 20px;
  border-radius: 8px;
  margin-top: 25px;
}
.chart-container {
  position: relative;
  height: 40vh; /* 40% da altura da tela */
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.stat-card {
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.stat-number, .stat-text, .stat-progress {
  font-size: 2.5rem;
  font-weight: bold;
  color: #42b983;
  margin: 10px 0;
}

.stat-text {
  font-size: 1.5rem;
}
</style>
