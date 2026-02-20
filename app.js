const startScanBtn = document.getElementById('startScanBtn');
const stopScanBtn = document.getElementById('stopScanBtn');
const scannerSection = document.getElementById('scannerSection');
const scannerStatus = document.getElementById('scannerStatus');
const result = document.getElementById('result');
const video = document.getElementById('video');

let stream;
let detector;
let scanInterval;

const stopScanner = () => {
  if (scanInterval) {
    clearInterval(scanInterval);
    scanInterval = null;
  }

  if (stream) {
    stream.getTracks().forEach((track) => track.stop());
    stream = null;
  }

  video.srcObject = null;
  scannerSection.classList.add('hidden');
};

const handleQRCode = (code) => {
  stopScanner();
  result.hidden = false;
  result.textContent = `QRCode detectado: ${code}`;

  setTimeout(() => {
    window.location.href = `aluno.html?codigo=${encodeURIComponent(code)}`;
  }, 800);
};

const startScanner = async () => {
  result.hidden = true;

  if (!('BarcodeDetector' in window)) {
    scannerStatus.textContent =
      'Seu navegador não suporta leitura nativa de QRCode. Use um navegador mais recente.';
    scannerSection.classList.remove('hidden');
    return;
  }

  try {
    detector = new BarcodeDetector({ formats: ['qr_code'] });
    stream = await navigator.mediaDevices.getUserMedia({
      video: { facingMode: { ideal: 'environment' } },
      audio: false,
    });

    video.srcObject = stream;
    await video.play();

    scannerStatus.textContent = 'Aponte a câmera para o QRCode do aluno.';
    scannerSection.classList.remove('hidden');

    scanInterval = setInterval(async () => {
      if (!video.videoWidth || !video.videoHeight) {
        return;
      }

      const barcodes = await detector.detect(video);
      if (barcodes.length > 0) {
        const code = barcodes[0].rawValue;
        handleQRCode(code);
      }
    }, 500);
  } catch (error) {
    scannerStatus.textContent =
      'Não foi possível acessar a câmera. Verifique as permissões do navegador.';
    scannerSection.classList.remove('hidden');
  }
};

startScanBtn.addEventListener('click', startScanner);
stopScanBtn.addEventListener('click', stopScanner);
