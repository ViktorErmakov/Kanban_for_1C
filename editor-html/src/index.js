import './style.css';
import './style_quill_1.3.7.css';
import Quill from './quill_1.3.7';

let UserName = "";
const quillEditors = {};
const toolbarOptions = [
  [{ 'font': [] }],
  // [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
  ['blockquote', 'code-block'],
  // [{ 'header': 1 }, { 'header': 2 }],               // custom button values
  [{ 'list': 'ordered' }, { 'list': 'bullet' }],
  [{ 'script': 'sub' }, { 'script': 'super' }],      // superscript/subscript
  [{ 'indent': '-1' }, { 'indent': '+1' }],          // outdent/indent
  [{ 'direction': 'rtl' }],                         // text direction

  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
  [{ 'align': [] }],
  ['clean']                                         // remove formatting button
];

window['V8Proxy'] = {

  // Для запроса из JS в 1С
  fetch: (eventName, value) => {

    // const taskButton = document.querySelector(`.${value}`);
    const V8_request = document.querySelector(`#V8_request`);
    V8_request.value = eventName;
    V8_request.textContent = value;
    V8_request.click();
  },
  // Для отправки из 1С в JS
  sendResponse: (eventName, value, userName1C) => {

    // console.log(eventName);
    // console.log(value);
    // console.log(userName1C);

    UserName = userName1C;
    importTasks(value);

  }
}

// Инициализация
document.addEventListener('DOMContentLoaded', function () {

  // НОВЫЙ РЕДАКТОР
  quillEditors['main-editor'] = new Quill('#editor', {
    theme: 'snow',
    placeholder: 'Введите текст задачи...',
    modules: {
      toolbar: toolbarOptions
    },
    // scrollingContainer: '#scrolling-container'
  });
  quillEditors['main-editor'].focus();

  window.V8Proxy.fetch('importTasks');

  document.getElementById('searchBtn').addEventListener('click', searchTasks);

  // Добавляем обработчики для поиска
  const searchInput = document.getElementById('searchInput');
  const clearSearchBtn = document.getElementById('clearSearchBtn');

  searchInput.addEventListener('keyup', function (e) {
    if (e.key === 'Enter') {
      searchTasks();
    }

    // Показываем/скрываем кнопку очистки
    if (this.value.trim() !== '') {
      clearSearchBtn.classList.add('visible');
    } else {
      clearSearchBtn.classList.remove('visible');
    }

  });

  // Обработчик для кнопки очистки
  clearSearchBtn.addEventListener('click', function () {
    searchInput.value = '';
    this.classList.remove('visible');
    clearSearch();
  });

  // Добавление задачи по нажатию Enter (Shift+Enter для новой строки)
  document.getElementById('editor').addEventListener('keydown', function (e) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      addTask();
    }
  });

  document.getElementById('addTaskBtn').addEventListener('click', addTask);

  // Добавление новой задачи
  function addTask() {
    const taskInput = document.getElementById('editor');
    const taskContent = taskInput.innerHTML.trim();


    if (!taskContent) return;

    const tasksContainer = document.getElementById('tasksContainer');
    const now = new Date();
    const timestamp = formatDate(now);

    const taskId = 'task-' + Date.now();

    const taskCard = document.createElement('div');
    taskCard.className = 'task-card';
    taskCard.id = taskId;

    const task = {
      created: timestamp,
    };

    taskCard.innerHTML = editorHTML(task, taskId);
    taskCard.querySelector('.edit-btn').onclick = () => enableEdit(taskId); // Добавляем обработчик для кнопки редактирования
    taskCard.querySelector('.save-btn').onclick = () => saveTask(taskId);
    taskCard.querySelector('.cancel-btn').onclick = () => cancelEdit(taskId);

    const editInput = taskCard.querySelector(`.edit-input`);
    if (editInput) {
      quillEditors[taskId] = new Quill(editInput, {
        theme: "snow",
        modules: { toolbar: toolbarOptions }
      });
    }

    tasksContainer.appendChild(taskCard);

    // Вставляем текст в редактор
    quillEditors[taskId].clipboard.dangerouslyPasteHTML(quillEditors['main-editor'].root.innerHTML);

    // Очищаем основной редактор
    quillEditors['main-editor'].deleteText(0, quillEditors['main-editor'].getLength());

    editMode(taskId, false);

    // вызываем код для получения JSON
    exportTasks();

  }

});

// Функция очистки поиска
function clearSearch() {
  const tasks = document.querySelectorAll('.task-card');
  tasks.forEach(task => {
    task.style.display = '';
    const quill = quillEditors[task.id];
    if (quill) {
      // Снимаем выделение (убираем background)
      quill.formatText(0, quill.getLength(), { background: false });
    }
  });
  document.getElementById('searchInfo').textContent = '';
}

// Поиск задач
function searchTasks() {
  const searchText = document.getElementById('searchInput').value.trim().toLowerCase();
  const tasks = document.querySelectorAll('.task-card');
  let foundCount = 0;

  if (!searchText) {
    clearSearch();
    return;
  }

  tasks.forEach(task => {
    const quill = quillEditors[task.id];
    let text = '';
    let found = false;

    if (quill) {
      text = quill.getText().toLowerCase();
      // Снимаем старую подсветку
      quill.formatText(0, quill.getLength(), { background: false });

      // Ищем все вхождения и подсвечиваем
      let startIndex = 0;
      while (true) {
        const index = text.indexOf(searchText, startIndex);
        if (index === -1) break;
        quill.formatText(index, searchText.length, { background: '#fff9c4' }); // цвет как в стилях .highlight
        startIndex = index + searchText.length;
        found = true;
      }
    }

    if (found) {
      task.style.display = '';
      foundCount++;
    } else {
      task.style.display = 'none';
    }
  });

  // Информация о результатах
  const searchInfo = document.getElementById('searchInfo');
  if (foundCount === 0) {
    searchInfo.textContent = 'Задачи не найдены';
  } else {
    searchInfo.textContent = `Найдено задач: ${foundCount}`;
  }
}



// Форматирование даты в русском формате
function formatDate(date) {
  const day = date.getDate().toString().padStart(2, '0');
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const year = date.getFullYear();
  const hours = date.getHours().toString().padStart(2, '0');
  const minutes = date.getMinutes().toString().padStart(2, '0');

  return `${day}.${month}.${year} ${hours}:${minutes}`;
}

// Экспорт задач в JSON
function exportTasks() {
  const tasks = [];
  const taskCards = document.querySelectorAll('.task-card');

  taskCards.forEach(card => {
    tasks.push({
      content: quillEditors[card.id].root.innerHTML,
      created: card.querySelector('.timestamp').textContent.replace('Создано: ', ''),
      updated: card.querySelector('.timestamp').textContent.includes('Обновлено: ')
        ? card.querySelector('.timestamp').textContent.replace('Обновлено: ', '')
        : null
    });
  });

  const dataStr = JSON.stringify(tasks, null, 2);
  window.V8Proxy.fetch('exportTasks', dataStr);

}

// Для отладки
// const value = JSON.stringify([
//     {
//         content: "<p><strong><em><u>новая</u></em>&nbsp;</strong><span class='ql-size-large' style='color: rgb(230, 0, 0);'>разная&nbsp;</span><span class='ql-size-huge' style='background-color: rgb(0, 138, 0);'>строка</span></p>",
//         created: "16.06.2025 21:23 Ermakov Viktor",
//         updated: null
//     },
//     {
//         content: "второй комментарий",
//         created: "16.06.2025 21:23 Ermakov Viktor",
//         updated: "16.06.2025 21:23 Ermakova Alena"
//     }
// ]);
// importTasks(value);

// Импорт задач из JSON
function importTasks(value) {

  const tasks = JSON.parse(value); // Это будет работать без ошибок

  tasks.forEach(task => {
    const taskId = 'task-' + Date.now();
    const taskCard = document.createElement('div');
    taskCard.className = 'task-card';
    taskCard.id = taskId;

    taskCard.innerHTML = editorHTML(task, taskId);
    taskCard.querySelector('.edit-btn').onclick = () => enableEdit(taskId); // Добавляем обработчик для кнопки редактирования
    taskCard.querySelector('.save-btn').onclick = () => saveTask(taskId);
    taskCard.querySelector('.cancel-btn').onclick = () => cancelEdit(taskId);
    
    const tasksContainer = document.getElementById('tasksContainer');
    tasksContainer.appendChild(taskCard);

    const editInput = document.querySelector(`#${taskId}.edit-input`);
    if (editInput) {
      quillEditors[taskId] = new Quill(editInput, {
        theme: "snow",
        modules: { toolbar: toolbarOptions }
      });
    };
    // Вставляем текст в редактор
    quillEditors[taskId].clipboard.dangerouslyPasteHTML(task.content);

    editMode(taskId, false);
  });
};

// Включение режима редактирования для задачи
function enableEdit(taskId) {
  editMode(taskId, true);
  const timestamp = document.querySelector(`#${taskId} .timestamp`);
  timestamp.textContent = `Обновлено: ${formatDate(new Date())} ${UserName}`;

}

// Сохранение отредактированной задачи
function saveTask(taskId) {
  const taskCard = document.getElementById(taskId);
  editMode(taskId, false);
}

// Отмена редактирования
function cancelEdit(taskId) {
  const taskCard = document.getElementById(taskId);
  const originalContent = taskCard.dataset.originalContent;
  if (originalContent !== undefined) {
    quillEditors[taskId].clipboard.dangerouslyPasteHTML(originalContent);
  }
  editMode(taskId, false);
}

function editMode(taskId, mode) {

  const editInput = document.querySelector(`#${taskId}.edit-input`);
  const taskCard = document.getElementById(taskId);

  taskId = taskCard.id;

  // Скрываем панель инструментов редактора
  const toolbar = taskCard.querySelector('.ql-toolbar');
  toolbar.classList.toggle('display_none');

  // Скрываем кнопки редактирования
  const editButtons = taskCard.querySelector('.edit-buttons');
  editButtons.classList.toggle('display_none');

  editInput.classList.toggle('border_none');

  // Изменяем режим редактирования 
  quillEditors[taskId].enable(mode);

  const task_actions = taskCard.querySelector('.task-actions');
  if (mode) {
    // Показываем панель инструментов редактора
    task_actions.classList.add('display_none');

    quillEditors[taskId].focus();
    const length = quillEditors[taskId].getLength();
    quillEditors[taskId].setSelection(length, 0);


    // Сохраняем исходное содержимое при начале редактирования
    taskCard.dataset.originalContent = quillEditors[taskId].root.innerHTML;
  } else {
    task_actions.classList.remove('display_none');
  }
}

function editorHTML(task, taskId) {

  const editorHTML = `
                <div id="scrolling-container">
                    <div id="editor">
                        <div class="editor_container">
                            <div class="editor_toolbar_content">
                                <div id=${taskId} class="edit-input"></div>
                            </div>
                            <div class="task-actions">
                                <button class="edit-btn">
                                    <svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M13.94 5L19 10.06L9.062 20H4V14.938L13.94 5ZM13.94 5L15.757 3.18299C16.144 2.79699 16.776 2.79699 17.162 3.18299L20.818 6.83899C21.204 7.22499 21.204 7.85699 20.818 8.24299L19 10.06M13.94 5L19 10.06" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                        <div class="timestamp">${task.updated ? 'Обновлено: ' + task.updated : 'Создано: ' + task.created}</div>
                        <div class="edit-buttons">
                            <button class="save-btn" onclick="saveTask('${taskId}')">Сохранить</button>
                            <button class="cancel-btn" onclick="cancelEdit('${taskId}')">Отмена</button>
                        </div>
                    </div>
                </div>
            `;
  return editorHTML;
}