import React from 'react';

export const Input = ({ value, onChange, placeholder = '' }: {
  value: string;
  onChange: (value: string) => void;
  placeholder?: string;
}) => (
  <input
    value={value}
    onChange={e => onChange(e.target.value)}
    placeholder={placeholder}
    style={{
      padding: '8px',
      border: '1px solid #ccc',
      borderRadius: '4px',
      margin: '4px 0',
      width: '100%',
      boxSizing: 'border-box',
    }}
  />
);
