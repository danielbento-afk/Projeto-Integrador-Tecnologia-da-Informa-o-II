<template>
  <div class="container schedule-page">
    <router-link to="/dashboard" class="router-link-back">&larr; Voltar para o Dashboard</router-link>
    <h1>Meu Cronograma de Estudos</h1>

    <div class="card calendar-container">
      <div class="calendar-header">
        <button @click="previousMonth" class="nav-button">&lt;</button>
        <h2>{{ displayedMonthYear }}</h2>
        <button @click="nextMonth" class="nav-button">&gt;</button>
      </div>
      <div class="calendar-grid">
        <div v-for="dayName in weekDays" :key="dayName" class="weekday-header">{{ dayName }}</div>
        <div 
          v-for="(day, index) in calendarDays" 
          :key="index" 
          class="calendar-day"
          :class="{ 
            'not-in-month': !day.isInCurrentMonth,
            'is-today': day.isToday 
          }"
        >
          <div class="day-number">{{ day.dayOfMonth }}</div>
          <div class="events-container">
            <div v-for="event in day.events" :key="event.id" class="event-item">
              {{ event.discipline }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const weekDays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
const currentDate = ref(new Date());

// --- DADOS SIMULADOS DE CRONOGRAMA ---
// Em um app real, isso viria do backend com base no cronograma gerado.
// O formato da chave 'YYYY-MM-DD' é importante para a busca.
const scheduleData = ref({
  '2025-10-08': [{ id: 1, discipline: 'Cálculo I' }],
  '2025-10-10': [{ id: 2, discipline: 'Física' }, { id: 3, discipline: 'Algoritmos' }],
  '2025-10-13': [{ id: 4, discipline: 'Cálculo I' }],
  '2025-10-15': [{ id: 5, discipline: 'Banco de Dados' }],
  '2025-10-17': [{ id: 6, discipline: 'Física' }],
  '2025-10-20': [{ id: 7, discipline: 'Cálculo I' }],
  '2025-11-03': [{ id: 8, discipline: 'Eng. de Software' }], // Evento para o próximo mês
});

const displayedMonthYear = computed(() => {
  return currentDate.value.toLocaleDateString('pt-BR', {
    month: 'long',
    year: 'numeric',
  }).replace(/^\w/, (c) => c.toUpperCase()); // Coloca a primeira letra em maiúsculo
});

// A "mágica" do calendário acontece aqui
const calendarDays = computed(() => {
  const year = currentDate.value.getFullYear();
  const month = currentDate.value.getMonth(); // 0 = Janeiro, 11 = Dezembro

  const firstDayOfMonth = new Date(year, month, 1);
  const lastDayOfMonth = new Date(year, month + 1, 0);

  const daysInMonth = lastDayOfMonth.getDate();
  const startDayOfWeek = firstDayOfMonth.getDay(); // 0 = Domingo, 6 = Sábado

  const days = [];
  
  // 1. Adiciona os dias "vazios" do mês anterior para preencher a primeira semana
  for (let i = 0; i < startDayOfWeek; i++) {
    days.push({ isInCurrentMonth: false });
  }

  // 2. Adiciona os dias do mês atual
  const today = new Date();
  for (let day = 1; day <= daysInMonth; day++) {
    const date = new Date(year, month, day);
    const dateString = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    
    days.push({
      dayOfMonth: day,
      date: dateString,
      isInCurrentMonth: true,
      isToday: date.toDateString() === today.toDateString(),
      events: scheduleData.value[dateString] || []
    });
  }
  
  return days;
});

const previousMonth = () => {
  const newDate = new Date(currentDate.value);
  newDate.setMonth(newDate.getMonth() - 1);
  currentDate.value = newDate;
};

const nextMonth = () => {
  const newDate = new Date(currentDate.value);
  newDate.setMonth(newDate.getMonth() + 1);
  currentDate.value = newDate;
};
</script>

<style scoped>
.schedule-page h1 {
  text-align: center;
  margin-bottom: calc(var(--spacing-unit) * 2);
}

.calendar-container {
  padding: calc(var(--spacing-unit) * 2);
  background-color: white;
  border-radius: var(--border-radius-base);
  box-shadow: 0 4px 12px var(--shadow-light);
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: calc(var(--spacing-unit) * 2);
  padding: 0 var(--spacing-unit);
}

.calendar-header h2 {
  margin: 0;
  color: var(--primary-dark-color);
  font-size: 1.75rem;
  text-align: center;
  flex-grow: 1;
}

.nav-button {
  background-color: transparent;
  border: 2px solid var(--primary-color);
  color: var(--primary-color);
  border-radius: 50%;
  width: 40px;
  height: 40px;
  font-size: 1.5rem;
  font-weight: bold;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: all 0.2s ease;
}

.nav-button:hover {
  background-color: var(--primary-color);
  color: white;
}

.calendar-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 5px;
}

.weekday-header {
  text-align: center;
  font-weight: 600;
  color: #7f8c8d;
  padding-bottom: var(--spacing-unit);
}

.calendar-day {
  border: 1px solid var(--border-color);
  border-radius: var(--border-radius-base);
  min-height: 120px;
  padding: 8px;
  background-color: #fff;
  transition: background-color 0.2s ease;
}

.calendar-day.not-in-month {
  background-color: var(--bg-light);
  opacity: 0.7;
}

.calendar-day.is-today {
  border-color: var(--primary-color);
  border-width: 2px;
}

.day-number {
  font-weight: 500;
  font-size: 0.9rem;
  margin-bottom: 5px;
}

.calendar-day.is-today .day-number {
  color: var(--primary-color);
  font-weight: 700;
}

.events-container {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.event-item {
  background-color: var(--secondary-color);
  color: white;
  padding: 4px 6px;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 500;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>