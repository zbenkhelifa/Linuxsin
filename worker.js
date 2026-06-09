const ALLOWED_ORIGIN = env => env.ALLOWED_ORIGIN || '*';

function cors(origin) {
  return {
    'Access-Control-Allow-Origin': origin,
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
  };
}

function json(body, status, origin) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json', ...cors(origin) },
  });
}

function buildEmailHtml(classroomLink) {
  return `
<div style="font-family:monospace;max-width:600px;margin:0 auto;background:#0D0D0D;color:#F5F5F0;padding:32px;border-radius:4px;">
  <h1 style="color:#00FF88;font-size:1.4rem;margin-bottom:8px;">🐧 Bienvenue sur LinuxSIN !</h1>
  <p style="color:#8A8A8A;margin-bottom:24px;">Ta formation Linux commence maintenant.</p>
  <p style="margin-bottom:16px;">Voici ton lien pour démarrer le TP0 :</p>
  <a href="${classroomLink}"
     style="display:inline-block;background:#00FF88;color:#0D0D0D;padding:12px 24px;font-weight:700;text-decoration:none;margin-bottom:24px;">
    👉 Accéder au TP0
  </a>
  <hr style="border-color:#2A2A2A;margin:24px 0;">
  <p style="color:#8A8A8A;margin-bottom:8px;">Comment démarrer :</p>
  <ol style="color:#F5F5F0;line-height:2;">
    <li>Clique sur le lien ci-dessus</li>
    <li>Crée ton compte GitHub si tu n'en as pas encore</li>
    <li>Fork le repo → tu as ta copie personnelle</li>
    <li>Lis le TP0 en premier — il explique tout</li>
  </ol>
  <hr style="border-color:#2A2A2A;margin:24px 0;">
  <p style="color:#8A8A8A;margin-bottom:8px;">Ce que tu vas apprendre :</p>
  <table style="width:100%;color:#F5F5F0;line-height:2;">
    <tr><td style="color:#00FF88;">TP0</td><td>Mise en route</td></tr>
    <tr><td style="color:#00FF88;">TP1</td><td>Navigation et fichiers Linux</td></tr>
    <tr><td style="color:#00FF88;">TP2</td><td>Permissions et utilisateurs</td></tr>
    <tr><td style="color:#00FF88;">TP3</td><td>Scripts bash</td></tr>
    <tr><td style="color:#00FF88;">TP4</td><td>Réseau et protocoles</td></tr>
    <tr><td style="color:#00FF88;">TP5</td><td>Mini-projet complet</td></tr>
  </table>
  <hr style="border-color:#2A2A2A;margin:24px 0;">
  <p style="color:#8A8A8A;font-size:0.85rem;">
    2 mois d'accès gratuit · sans carte bancaire<br>
    — L'équipe LinuxSIN
  </p>
</div>`;
}

export default {
  async fetch(request, env) {
    const origin = ALLOWED_ORIGIN(env);

    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: cors(origin) });
    }

    if (request.method !== 'POST') {
      return json({ error: 'Method not allowed' }, 405, origin);
    }

    let email;
    try {
      const body = await request.json();
      email = (body.email || '').trim().toLowerCase();
    } catch {
      return json({ error: 'Invalid JSON' }, 400, origin);
    }

    if (!email || !email.includes('@') || !email.includes('.')) {
      return json({ error: 'Invalid email' }, 400, origin);
    }

    const res = await fetch('https://api.brevo.com/v3/smtp/email', {
      method: 'POST',
      headers: {
        'api-key': env.BREVO_KEY,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        sender: { email: env.BREVO_SENDER, name: 'LinuxSIN' },
        to: [{ email }],
        subject: '🐧 Ton accès LinuxSIN — commence ici !',
        htmlContent: buildEmailHtml(env.CLASSROOM_LINK),
      }),
    });

    if (!res.ok) {
      const err = await res.json().catch(() => ({}));
      console.error('Brevo error:', JSON.stringify(err));
      return json({ error: 'Email delivery failed' }, 502, origin);
    }

    return json({ ok: true }, 200, origin);
  },
};
