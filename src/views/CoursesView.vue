<template>
  <div class="container courses-page">
    <router-link to="/dashboard" class="router-link-back">&larr; Voltar para o Dashboard</router-link>
    <h1>Cadastro de Cursos e Disciplinas</h1>

    <div class="card add-course-section">
      <h2>Adicionar Novo Curso</h2>
      <form @submit.prevent="addCourse">
        <div class="form-group">
          <label for="newCourseName">Nome do Curso</label>
          <input type="text" id="newCourseName" v-model="newCourseName" placeholder="Ex: Engenharia de Software - 3º Semestre" required>
        </div>
        <button type="submit">Adicionar Curso</button>
      </form>
    </div>

    <div class="card my-courses-section">
      <h2>Meus Cursos</h2>
      <div v-if="courses.length === 0" class="empty-state">
        <p>Nenhum curso cadastrado ainda. Comece adicionando um!</p>
      </div>

      <div v-for="course in courses" :key="course.id" class="course-item">
        <div class="course-header">
          <h3>{{ course.name }}</h3>
          <button @click="removeCourse(course.id)" class="btn-remove">Remover Curso</button>
        </div>

        <div class="add-discipline-section">
          <h4>Adicionar Nova Disciplina</h4>
          <form @submit.prevent="addDiscipline(course)">
            <div class="form-group">
              <label :for="'disciplineName-' + course.id" class="sr-only">Nome da Disciplina</label>
              <input type="text" :id="'disciplineName-' + course.id" v-model="course.newDisciplineName" placeholder="Ex: Estrutura de Dados" required>
            </div>
            <div class="form-group">
              <label :for="'disciplineHours-' + course.id" class="sr-only">Carga Horária (h)</label>
              <input type="number" :id="'disciplineHours-' + course.id" v-model.number="course.newDisciplineHours" placeholder="Carga Horária Mensal (h)" min="1" required>
            </div>
            <button type="submit">Adicionar Disciplina</button>
          </form>
        </div>

        <div class="discipline-list">
          <h4>Disciplinas</h4>
          <div v-if="course.disciplines.length === 0" class="empty-state">
            <p>Nenhuma disciplina adicionada a este curso.</p>
          </div>
          <ul>
            <li v-for="discipline in course.disciplines" :key="discipline.id" class="discipline-item">
              <span>{{ discipline.name }} ({{ discipline.hours }}h)</span>
              <button @click="removeDiscipline(course, discipline.id)" class="btn-remove-small">x</button>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const newCourseName = ref('');
const courses = ref([
  // Dados simulados
  {
    id: 1,
    name: 'Engenharia de Software - 3º Semestre',
    newDisciplineName: '', // Para o input de nova disciplina
    newDisciplineHours: null, // Para o input de carga horária
    disciplines: [
      { id: 101, name: 'Estrutura de Dados', hours: 60 },
      { id: 102, name: 'Banco de Dados', hours: 80 }
    ]
  }
]);

const addCourse = () => {
  if (newCourseName.value.trim()) {
    const newId = courses.value.length > 0 ? Math.max(...courses.value.map(c => c.id)) + 1 : 1;
    courses.value.push({
      id: newId,
      name: newCourseName.value,
      newDisciplineName: '',
      newDisciplineHours: null,
      disciplines: []
    });
    newCourseName.value = '';
  }
};

const removeCourse = (courseId) => {
  if (confirm('Tem certeza que deseja remover este curso e todas as suas disciplinas?')) {
    courses.value = courses.value.filter(c => c.id !== courseId);
  }
};

const addDiscipline = (course) => {
  if (course.newDisciplineName.trim() && course.newDisciplineHours > 0) {
    const newId = course.disciplines.length > 0 ? Math.max(...course.disciplines.map(d => d.id)) + 1 : 1;
    course.disciplines.push({
      id: newId,
      name: course.newDisciplineName,
      hours: parseInt(course.newDisciplineHours)
    });
    course.newDisciplineName = '';
    course.newDisciplineHours = null;
  }
};

const removeDiscipline = (course, disciplineId) => {
  if (confirm('Tem certeza que deseja remover esta disciplina?')) {
    course.disciplines = course.disciplines.filter(d => d.id !== disciplineId);
  }
};
</script>

<style scoped>
.courses-page h1 {
  text-align: center;
  margin-bottom: var(--spacing-unit) * 3;
  color: var(--primary-dark-color);
}

.card {
  margin-bottom: calc(var(--spacing-unit) * 2);
  padding: calc(var(--spacing-unit) * 2);
  background-color: white;
  border-radius: var(--border-radius-base);
  box-shadow: 0 4px 12px var(--shadow-light);
}

.add-course-section h2, .my-courses-section h2 {
  color: var(--primary-color);
  margin-top: 0;
  margin-bottom: calc(var(--spacing-unit) * 1.5);
}

/* Estilo para cada item de curso */
.course-item {
  background-color: var(--bg-dark); /* Fundo um pouco mais escuro para diferenciar */
  padding: calc(var(--spacing-unit) * 1.5);
  border-radius: var(--border-radius-base);
  margin-bottom: var(--spacing-unit) * 1.5;
  box-shadow: 0 2px 8px var(--shadow-light);
  border: 1px solid var(--border-color); /* Borda sutil */
}

.course-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: calc(var(--spacing-unit) * 1.5);
  padding-bottom: var(--spacing-unit);
  border-bottom: 1px solid var(--border-color);
}

.course-header h3 {
  margin: 0; /* Remover margem padrão */
  color: var(--text-color-dark);
}

/* Seção de adicionar disciplina dentro do curso */
.add-discipline-section {
  background-color: #f0f3f6; /* Fundo ainda mais claro para o formulário interno */
  padding: var(--spacing-unit);
  border-radius: var(--border-radius-base);
  margin-bottom: var(--spacing-unit) * 1.5;
  border: 1px dashed var(--border-color);
}

.add-discipline-section h4 {
  margin-top: 0;
  margin-bottom: var(--spacing-unit);
  color: var(--text-color-dark);
  font-size: 1.1rem;
}

/* Ajustes para inputs dentro da seção de disciplina */
.add-discipline-section .form-group {
  margin-bottom: var(--spacing-unit);
  display: flex;
  gap: var(--spacing-unit);
}

.add-discipline-section .form-group input {
  flex: 1; /* Para inputs ocuparem o espaço disponível */
}

.add-discipline-section button {
  width: 100%; /* Botão Adicionar Disciplina ocupa a largura total */
}

/* Lista de Disciplinas */
.discipline-list {
  margin-top: calc(var(--spacing-unit) * 2);
}

.discipline-list h4 {
  font-size: 1.1rem;
  color: var(--primary-dark-color);
  margin-bottom: var(--spacing-unit);
}

.discipline-list ul {
  list-style: none; /* Remover marcadores de lista */
  padding: 0;
}

.discipline-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #ffffff;
  padding: var(--spacing-unit);
  border: 1px solid var(--border-color);
  border-radius: var(--border-radius-base);
  margin-bottom: calc(var(--spacing-unit) * 0.75);
  box-shadow: 0 1px 4px var(--shadow-light);
}

.discipline-item span {
  font-weight: 500;
  color: var(--text-color-dark);
  flex-grow: 1; /* Permite que o texto ocupe o espaço */
  text-align: left;
}

.btn-remove {
  background-color: #e74c3c; /* Vermelho para remover */
  color: white;
  padding: calc(var(--spacing-unit) * 0.5) calc(var(--spacing-unit));
  font-size: 0.9rem;
  font-weight: 500;
}

.btn-remove:hover {
  background-color: #c0392b;
}

.btn-remove-small {
  background-color: #e74c3c; /* Vermelho para remover */
  color: white;
  padding: 5px 10px; /* Padding menor */
  font-size: 0.8rem;
  font-weight: bold;
  border-radius: 50%; /* Botão redondo */
  width: 30px;
  height: 30px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-left: var(--spacing-unit); /* Espaçamento do texto */
}

.empty-state {
  text-align: center;
  color: #7f8c8d;
  padding: calc(var(--spacing-unit) * 2);
  background-color: var(--bg-dark);
  border-radius: var(--border-radius-base);
  margin-bottom: var(--spacing-unit) * 1.5;
  font-style: italic;
}

/* Acessibilidade */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}

/* Responsividade */
@media (max-width: 768px) {
  .add-discipline-section .form-group {
    flex-direction: column;
    gap: 0.5rem;
  }
  .add-discipline-section .form-group input {
    width: 100%;
  }
}
</style>