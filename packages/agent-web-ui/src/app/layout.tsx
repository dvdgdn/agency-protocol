import './global.css';

export const metadata = {
  title: 'Agency Protocol Dashboard',
  description: 'Agency Protocol - Parallel Agent Model',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body style={{ backgroundColor: '#f7f7f7', margin: 0, padding: 0 }}>
        {children}
      </body>
    </html>
  );
}