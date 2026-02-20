const teacherLoginForm = document.querySelector('#teacherLoginForm');
const teacherEmailInput = document.querySelector('#teacherEmail');
const scanQrButton = document.querySelector('#scanQrButton');
const studentCodeForm = document.querySelector('#studentCodeForm');
const studentCodeInput = document.querySelector('#studentCode');
const resultPanel = document.querySelector('#resultPanel');
const resultTitle = document.querySelector('#resultTitle');
const resultDescription = document.querySelector('#resultDescription');

const showResult = (title, description) => {
  resultTitle.textContent = title;
  resultDescription.textContent = description;
  resultPanel.classList.remove('hidden');
};

teacherLoginForm?.addEventListener('submit', (event) => {
  event.preventDefault();

  const email = teacherEmailInput.value.trim();
  showResult(
    'Acesso do professor liberado',
    `Login realizado com sucesso para ${email}. Painel da turma disponível.`
  );
});

scanQrButton?.addEventListener('click', () => {
  studentCodeInput.value = 'ALUNO-3A-045';
  studentCodeInput.focus();

  showResult(
    'QR Code escaneado',
    'Código capturado. Confirme para entrar no perfil do aluno.'
  );
});

studentCodeForm?.addEventListener('submit', (event) => {
  event.preventDefault();

  const code = studentCodeInput.value.trim();
  showResult(
    'Acesso do aluno liberado',
    `Código ${code} validado. Perfil do aluno carregado com sucesso.`
  );
});
