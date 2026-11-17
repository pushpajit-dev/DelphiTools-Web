import { flowHooks } from './flow-hooks';

function showToastNotification(message: string): void {
	if (typeof (window as any).AndroidNative?.showToast === 'function') {
		(window as any).AndroidNative.showToast(message);
	}
	if (typeof document !== 'undefined') {
		let container = document.getElementById('dt-native-toast-container');
		if (!container) {
			container = document.createElement('div');
			container.id = 'dt-native-toast-container';
			container.style.cssText =
				'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);z-index:99999;background:var(--primary, #0f172a);color:var(--primary-foreground, #ffffff);padding:10px 20px;border-radius:24px;box-shadow:0 4px 16px rgba(0,0,0,0.35);font-size:14px;font-weight:500;pointer-events:none;transition:opacity 0.25s,transform 0.25s;opacity:0;';
			document.body.appendChild(container);
		}
		container.textContent = message;
		container.style.opacity = '1';
		setTimeout(() => {
			if (container) container.style.opacity = '0';
		}, 2600);
	}
}

function click(url: string, filename: string): void {
	const link = document.createElement('a');
	link.href = url;
	link.download = filename;
	link.click();
}

export function downloadUrl(url: string, filename: string): void {
	const flow = flowHooks.current;
	if (flow?.capturing) {
		void fetch(url)
			.then((response) => response.blob())
			.then((blob) =>
				flow.capture(
					new File([blob], filename, {
						type: blob.type,
					}),
				),
			)
			.catch(() => click(url, filename));
		return;
	}
	showToastNotification(`Downloading ${filename}...`);
	click(url, filename);
}

export function saveBlob(blob: Blob, filename: string): void {
	showToastNotification(`Saving ${filename}...`);
	if (typeof (window as any).AndroidNative?.saveFile === 'function') {
		const reader = new FileReader();
		reader.onloadend = () => {
			const res = reader.result as string;
			const comma = res.indexOf(',');
			const base64 = comma !== -1 ? res.slice(comma + 1) : res;
			(window as any).AndroidNative.saveFile(
				filename,
				blob.type || 'application/octet-stream',
				base64,
			);
		};
		reader.readAsDataURL(blob);
		return;
	}

	const url = URL.createObjectURL(blob);
	click(url, filename);
	// revoke after download starts
	setTimeout(() => URL.revokeObjectURL(url), 1000);
}

export function downloadBlob(blob: Blob, filename: string): void {
	const flow = flowHooks.current;
	if (flow?.capturing) {
		flow.capture(new File([blob], filename, { type: blob.type }));
		return;
	}
	saveBlob(blob, filename);
}

export function downloadText(
	text: string,
	filename: string,
	mimeType = 'text/plain;charset=utf-8',
): void {
	downloadBlob(new Blob([text], { type: mimeType }), filename);
}
