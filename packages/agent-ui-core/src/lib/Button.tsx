import React from 'react';

export const Button = ({ onClick, children, type = 'button' }: {
  onClick?: React.MouseEventHandler<HTMLButtonElement>;
  children: React.ReactNode;
  type?: 'button' | 'submit' | 'reset';
}) => (
  <button
    type={type}
    onClick={onClick}
    style={{
      padding: '8px 16px',
      border: 'none',
      borderRadius: '4px',
      backgroundColor: '#1a73e8',
      color: '#fff',
      cursor: 'pointer',
    }}
  >
    {children}
  </button>
);
