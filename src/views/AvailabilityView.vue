<template>
  <div class="container availability-page">
    <router-link to="/dashboard" class="router-link-back">&larr; Voltar para o Dashboard</router-link>
    <h1>Disponibilidade de Estudo Semanal</h1>

    <div class="availability-layout">
      <div class="card availability-form">
        <h2>Defina seus Horários</h2>
        <p class="description">
          Selecione os dias em que você pretende estudar e informe a média de horas de estudo para esses dias.
        </p>

        <form @submit.prevent="calculateAvailability">
          <div class="form-group">
            <label>1. Quais dias da semana você tem disponível?</label>
            <div class="days-selector">
              <div v-for="day in daysOfWeek" :key="day.id" class="day-option">
                <input type="checkbox" :id="day.id" :value="day.id" v-model="selectedDays">
                <label :for="day.id">{{ day.name }}</label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="hoursPerDay">2. Em média, quantas horas por dia você pode estudar?</label>
            <input type="number" id="hoursPerDay" v-model.number="hoursPerDay" min="1" max="12" required>
          </div>

          <button type="submit">Calcular e Salvar Disponibilidade</button>
        </form>
      </div>

      <div v-if="showSummary" class="card availability-summary">
        <h2>Análise da sua Disponibilidade</h2>
        <div class="summary-item">
          <span>Carga Horária Necessária:</span>
          <strong class="required">{{ totalDemandHours }} horas/semana</strong>
        </div>
        <div class="summary-item">
          <span>Sua Disponibilidade:</span>
          <strong class="available">{{ calculation.availableHours }} horas/semana</strong>
        </div>
        <div class="summary-result" :class="calculation.status">
          <p>{{ calculation.message }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue';

// Dados para o formulário
const daysOfWeek = [
  { id: 'seg', name: 'Seg' },
  { id: 'ter', name: 'Ter' },
  { id: 'qua', name: 'Qua' },
  { id: 'qui', name: 'Qui' },
  { id: 'sex', name: 'Sex' },
  { id: 'sab', name: 'Sáb' },
  { id: 'dom', name: 'Dom' },
];

const selectedDays = ref(['seg', 'qua', 'sex']); // Valor inicial de exemplo
const hoursPerDay = ref(3); // Valor inicial de exemplo
const showSummary = ref(false);

// --- DADOS SIMULADOS ---
// Em uma aplicação real, este valor viria da soma da carga horária
// de todas as disciplinas que o usuário cadastrou.
const totalDemandHours = ref(18); // Ex: 3 matérias x 6h/semana cada

const calculation = reactive({
  availableHours: 0,
  message: '',
  status: 'ok', // pode ser 'ok' ou 'warning'
});

const calculateAvailability = () => {
  // 1. Calcula a disponibilidade do usuário
  const available = selectedDays.value.length * hoursPerDay.value;
  calculation.availableHours = available;

  // 2. Compara com a demanda de horas
  if (available >= totalDemandHours.value) {
    calculation.message = "Ótimo! Sua disponibilidade semanal é suficiente para cobrir a carga horária das suas matérias.";
    calculation.status = 'ok';
  } else {
    calculation.message = `Atenção! Suas ${available} horas disponíveis são menores que as ${totalDemandHours.value} horas necessárias. Considere ajustar seus horários ou a distribuição das matérias.`;
    calculation.status = 'warning';
  }
  
  // 3. Simula o salvamento e exibe o resultado
  console.log('Salvando disponibilidade:', {
    days: selectedDays.value,
    hours: hoursPerDay.value,
  });
  showSummary.value = true;
};
</script>

<style scoped>
.availability-page h1 {
  text-align: center;
  margin-bottom: calc(var(--spacing-unit) * 2);
}

.description {
  color: #7f8c8d;
  margin-bottom: calc(var(--spacing-unit) * 2);
}

.availability-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: calc(var(--spacing-unit) * 2);
}

.card h2 {
  margin-top: 0;
  color: var(--primary-dark-color);
}

/* Estilo dos checkboxes de dia */
.days-selector {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(80px, 1fr));
  gap: var(--spacing-unit);
  margin-top: var(--spacing-unit);
}

.day-option input[type="checkbox"] {
  display: none; /* Esconde o checkbox padrão */
}

.day-option label {
  display: block;
  text-align: center;
  padding: var(--spacing-unit);
  border: 2px solid var(--border-color);
  border-radius: var(--border-radius-base);
  cursor: pointer;
  transition: all 0.2s ease;
  font-weight: 500;
}

.day-option input[type="checkbox"]:checked + label {
  background-color: var(--primary-color);
  color: white;
  border-color: var(--primary-dark-color);
  box-shadow: 0 2px 8px rgba(52, 152, 219, 0.4);
}

.day-option label:hover {
  border-color: var(--primary-color);
}

/* Seção de Resumo da Análise */
.availability-summary {
  background-color: var(--bg-dark);
}

.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--spacing-unit) 0;
  font-size: 1.1rem;
  border-bottom: 1px solid var(--border-color);
}

.summary-item:last-of-type {
  border-bottom: none;
}

.summary-item strong {
  font-weight: 600;
}

.summary-item .required {
  color: var(--accent-color);
}

.summary-item .available {
  color: var(--secondary-color);
}

.summary-result {
  margin-top: calc(var(--spacing-unit) * 2);
  padding: var(--spacing-unit);
  border-radius: var(--border-radius-base);
  text-align: center;
}

.summary-result.ok {
  background-color: #e0f7e0;
  border: 1px solid var(--secondary-color);
  color: #27ae60;
}

.summary-result.warning {
  background-color: #fce7e7;
  border: 1px solid #e74c3c;
  color: #c0392b;
}

/* Responsividade */
@media (max-width: 992px) {
  .availability-layout {
    grid-template-columns: 1fr;
  }
}
</style>