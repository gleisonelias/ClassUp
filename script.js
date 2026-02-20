const accessButton = document.querySelector('#accessButton');
const statusText = document.querySelector('#status');
const dashboard = document.querySelector('#dashboard');
const lastAccess = document.querySelector('#lastAccess');

accessButton?.addEventListener('click', () => {
  const now = new Date();
  const date = now.toLocaleString('pt-BR');

  statusText.textContent = `Acesso confirmado em ${date}.`;
  lastAccess.textContent = `Último acesso: ${date}`;
  dashboard.classList.remove('hidden');
  accessButton.disabled = true;
  accessButton.textContent = 'Acesso liberado';
});
