import React from 'react';

export const Card = ({ title, children }: { title: string, children: React.ReactNode }) => {
  return (
    <div style={{ 
      border: '1px solid #eee', 
      borderRadius: '8px', 
      padding: '16px', 
      margin: '1em', 
      boxShadow: '0 2px 4px rgba(0,0,0,0.1)', 
      backgroundColor: 'white' 
    }}>
      <h3 style={{ 
        marginTop: 0, 
        borderBottom: '1px solid #eee', 
        paddingBottom: '0.5em', 
        color: '#333' 
      }}>{title}</h3>
      {children}
    </div>
  );
};